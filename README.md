# ThermalCamera_MLX90640

-----------------------------
Description:
-----------------------
This Thermal-Camera Tutorial introduces the use of the MLX90640 WIDE model under two display settings:

a) MLX90640 + ESP32 + computer screen display via Processing (P3)
b) MLX90640 + Raspberry Pi + screen display via HDMI cable

You will find specific instructions for each approach in the corresponding folders.

------------------------------- 
MLX90640 Features:
-------------------------
- Detects: surface area temperatures
- Range: -40°C to 300°C
- WIDE Model: 110°x75° field of view
- Acuracy: 1.5°C
- Resolution: 32x24 px ()
- Voltage : 3 - 5V (internal 3 volts converter)
- Current consumption: ~18mA
- up to 64 FPS
- I2C interface 

Note: The MLX90640 measures infrared temperature only; it cannot capture RGB images from visible light. Instead, it detects heat emitted by objects, which can then be converted into a coloured image.

Note: Each pixel in the camera frame functions as an individual sensor point (an array of 32 × 24 = 768 pixels). Every pixel measures the temperature at its specific location, providing readings between −40 °C and 300 °C.

------------------------------
Compatibility:
------------------------
- Raspberry Pi
- ESP32
- Teensy 3.1 or higher
- Other micro-controllers of 20kB RAM or higher
- Not for Arduino boards. 

------------------------------
More Info:
------------------------
 
ADAFRUIT more info:
https://learn.adafruit.com/adafruit-mlx90640-ir-thermal-camera/overview

SPARKFUN more info:
https://learn.sparkfun.com/tutorials/qwiic-ir-array-mlx90640-hookup-guide
