import processing.serial.*;

Serial myPort;
String myString = null;
String[] splitString;
PImage heatmap;

// Visual range and gamma
float minVisual = 23;
float maxVisual = 35;
float gamma = 0.7;

// Colour transition points
float greenStart = 25;  // green begins
float greenEnd = 26;    // green ends
float redStart = 30;    // red begins
float magentaStart = 35; // magenta above this

// For frame smoothing
float[] temps = new float[768];
float smoothing = 0.5; // 0=no smoothing, 1=fully previous frame

void setup() {
  size(480, 400, P2D);
  smooth(8);
  noStroke();
  frameRate(60);
  colorMode(HSB, 360, 100, 100);

  println("Available serial ports:");
  printArray(Serial.list());

  String portName = autoDetectPort();
  if (portName == null) exit();

  myPort = new Serial(this, portName, 115200);
  myPort.clear();
  delay(1000);

  heatmap = createImage(32, 24, RGB);
}

void draw() {
  if (myPort.available() > 0) {
    myString = myPort.readStringUntil('\n');
    if (myString != null && myString.length() > 1000) {
      splitString = splitTokens(trim(myString), ",");
      if (splitString.length == 768) {

        heatmap.loadPixels();
        for (int i = 0; i < 768; i++) {
          float v = float(splitString[i]) / 10.0;

          // --- FRAME SMOOTHING ---
          temps[i] = smoothing * temps[i] + (1 - smoothing) * v;

          float hueVal;
          float temp = temps[i];

          if (temp < minVisual) hueVal = 240;                 // blue
          else if (temp < greenStart) {
            float norm = (temp - minVisual) / (greenStart - minVisual);
            norm = pow(norm, gamma);
            hueVal = map(norm, 0, 1, 240, 160);              // blue → cyan
          } else if (temp <= greenEnd) {
            float norm = (temp - greenStart) / (greenEnd - greenStart);
            norm = pow(norm, gamma);
            hueVal = map(norm, 0, 1, 160, 60);               // green → yellow
          } else if (temp < redStart) {
            float norm = (temp - greenEnd) / (redStart - greenEnd);
            norm = pow(norm, gamma);
            hueVal = map(norm, 0, 1, 60, 0);                 // yellow → red
          } else if (temp < magentaStart) hueVal = 0;         // red
          else hueVal = 320;                                  // magenta

          heatmap.pixels[i] = color(hueVal, 100, 100);
        }
        heatmap.updatePixels();

        background(0);
        image(heatmap, 0, 0, width, 360);
        drawLegend();
      }
    }
  }
}

void drawLegend() {
  textSize(24);
  float step = (maxVisual - minVisual) / 5.0;
  for (int i = 0; i <= 5; i++) {
    float t = minVisual + i * step;
    float hueVal;

    if (t < minVisual) hueVal = 240;
    else if (t < greenStart) hueVal = map(pow((t - minVisual)/(greenStart - minVisual), gamma), 0, 1, 240, 160);
    else if (t <= greenEnd) hueVal = map(pow((t - greenStart)/(greenEnd - greenStart), gamma), 0, 1, 160, 60);
    else if (t < redStart) hueVal = map(pow((t - greenEnd)/(redStart - greenEnd), gamma), 0, 1, 60, 0);
    else if (t < magentaStart) hueVal = 0;
    else hueVal = 320;

    fill(hueVal, 100, 100);
    text(nf(t, 0, 1) + "°C", 80 * i, 385);
  }
}

String autoDetectPort() {
  String[] ports = Serial.list();
  for (String port : ports) {
    port = port.toLowerCase();
    if ((port.contains("usb") || port.contains("com")) && !port.contains("bluetooth")) return port;
  }
  return null;
}
