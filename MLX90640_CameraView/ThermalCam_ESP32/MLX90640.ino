#include <Wire.h> // Library for I2C communication
#include <Adafruit_MLX90640.h>

Adafruit_MLX90640 mlx; // create a thermal camera object
float frame[32*24];  // 768 pixels

void setup() {
  Serial.begin(115200);
  delay(1000);             
  Wire.begin(SDA, SCL, 1000000);   // 1MHz clock speed for faster data transfer   

//init sensor
  if (!mlx.begin(0x33, &Wire)) { //0x33 com adress (MLX90640’s default I²C address)
    Serial.println("MLX90640 not found!");
    while(1);
  }

  mlx.setMode(MLX90640_INTERLEAVED); //pixel organization mode for fast transmition
  mlx.setResolution(MLX90640_ADC_18BIT);
  mlx.setRefreshRate(MLX90640_16_HZ); //give new data every 16 FPS
}

void loop() {
  if (mlx.getFrame(frame) != 0) return; // Failed to get frame

  // Send temperatures as integers ×10
  for (int i = 0; i < 32*24; i++) { // go through every pixel (768) in the thermal frame array
    int t = (int)(frame[i]*10); //make decimal values (e.g.: 23.5°C) into intergers (e.g.: 235)
    Serial.print(t);
    if (i < 32*24-1) Serial.print(",");
  }
  Serial.println();
}
