import processing.serial.*;

Serial myPort;
String myString = null; //line of values coming from serial
float[] temps = new float[768];
String[] splitString;
float maxTemp = 0;
float minTemp = 500;
PImage heatmap; //declare an image object to display temp

float minVisual = 22.0; // °C, anything below will be deep blue
float maxVisual = 30.0; // °C, anything above will be pink

void setup() {
  size(480, 400);
  noStroke();
  frameRate(60);
  colorMode(HSB, 360, 100, 100); //Hue, Saturation, Brightness
  // HUE: 0° = red, 120° = green, 240° = blue, 360° = back to red

  println("Available serial ports:");
  printArray(Serial.list());

  String portName = autoDetectPort();
  if (portName == null) {
    println("No ESP32 found. Plug it in and restart Processing.");
    exit();
  }
  println("Using port: " + portName);

  myPort = new Serial(this, portName, 115200);
  myPort.clear();
  delay(1000);
  myString = null;

  heatmap = createImage(32, 24, RGB); // 32x24 pixels (MLX90640 resolution)
}

void draw() {
  if (myPort.available() > 0) {
    myString = myPort.readStringUntil('\n');
    if (myString != null && myString.length() > 1000) {

      splitString = splitTokens(trim(myString), ",");
      if (splitString.length == 768) {

        // Reset min/max
        maxTemp = -1000;
        minTemp = 1000;

        // Compute min/max and normalise
        for (int i = 0; i < 768; i++) {
          float val = float(splitString[i]) / 10.0;
          if (val > maxTemp) maxTemp = val;
          if (val < minTemp) minTemp = val;
        }

        heatmap.loadPixels();
        for (int i = 0; i < 768; i++) {
          float val = float(splitString[i]) / 10.0;

          // Apply visual range and constrain
          float norm = (val - minVisual) / (maxVisual - minVisual);
          norm = constrain(norm, 0, 1);

          // Optional gamma for mid-range enhancement
          norm = pow(norm, 0.7);

          // Map to blue→pink spectrum
          float hueVal = map(norm, 0, 1, 180, 360); // 180°=blue, 360°=pink
          heatmap.pixels[i] = color(hueVal, 100, 100);
        }
        heatmap.updatePixels();


        // Draw scaled heatmap
        background(0);
        image(heatmap, 0, 0, width, 360); // scale to full width

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
    float norm = (t - minVisual) / (maxVisual - minVisual);
    norm = pow(norm, 0.7);
    float hueVal = map(norm, 0, 1, 180, 360);
    fill(hueVal, 100, 100);
    text(nf(t, 0, 1) + "°C", 80 * i, 385);
  }
}

String autoDetectPort() {
  String[] ports = Serial.list();
  for (String port : ports) {
    port = port.toLowerCase();
    if ((port.contains("usb") || port.contains("com")) && !port.contains("bluetooth")) {
      return port;
    }
  }
  return null;
}
