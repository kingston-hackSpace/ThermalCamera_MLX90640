# 
ThermalCamera_MLX90640
INSTRUCTIONS for ESP32 + Processing(P3)
----------------------------------------

ESP32
-----
STEP 1: Installing ESP32 dependancies 
- Open your Arduino IDE
- At the top menu, select:
    Arduino IDE > Settings...
    Fill "Additional boards manager URLs" copying the following into it: 
    https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_dev_index.json 
- Close/Re-open Arduino IDE
- Go to "Tools > Boards > Boards Manager"
- Search for "esp32 by Espressif Systems". Install. 
- Go to "Tools > Upload Speed > 125200"
- Plug the ESP32 to your computer if you haven't already
- At the top of your Arduino IDE screen, select the board: "Adafruit Feather ESP32 V2"
- Go to "File > Examples > 01.Basics > Blink"
- Upload the Blink example into your board to test that everything has gone well in your installation process.

More info about the ESP32: https://learn.adafruit.com/adafruit-esp32-feather-v2/arduino-ide-setup 

----------------------------
THERMAL CAMERA MLX90640
-----------------------

- Go to "Scketh > Include Library > Manage Libraries..."
- Search for "Adafruit MLX90640 by Adafruit". Install.
- Go to "File > Examples > (scroll down until you find:)
                            Adafruit MLX90640 > MLX90640_simpleTest"
                            
- Upload this example into your board to test that everything has gone well in your installation process.
- Now open and upload the Arduino Code provided in this tutorial, named "MLX90640_CameraView.ino"
- Open your Serial Monitor, you should see data printed in it. If You get a "exit 2" error, you need to repeat the following step:
    - Go to "Tools > Upload Speed > 125200"
- Close Arduino. You won't be able to run the Processing schetch if Arduino Serial Monitor is open.
    
More info about the MLX90640:
    https://learn.sparkfun.com/tutorials/qwiic-ir-array-mlx90640-hookup-guide 
    
----------------------------
PROCESSING P3
-----------------------
- Install Processing if you haven't already:
    https://processing.org/download?processing 
- 
- Open and run any of the .pde sckeths provided (Yellow or Pink). 


