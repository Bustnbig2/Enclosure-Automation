// 8/17/21


import processing.serial.*;
import meter.*;
import processing.video.*;

Meter m;
Meter m2;
Button light_button;
Button power_button;
Capture video;



Serial port;

float minTemp = 260;
float maxTemp = 0;
float minHum = 100;
float maxHum = 0;
float temp = 75;
float hum = 50;
float[] y = new float[0];
float[] z = new float[0];
float tempTimer = 0;
int tempInterval = 2100;
int h = 0;
int w = 0;
PImage img;

void setup() {
  size(955, 500);
  background(0, 0, 0);
  textSize(12);
  surface.setResizable(true);
  
  printArray(Capture.list());

  port = new Serial(this, "COM4", 115200);
  video = new Capture(this, 1280, 720);
  
  video.start();
  


  meterSetup();
 
  light_button = new Button("Light", 10, height - 100, width / 12, height / 15, #03BEFF, #0000FF);
  power_button = new Button("Power", light_button.x + light_button.w1 + 20, 
      light_button.y, light_button.w1, light_button.h1, #FF0000, #0000FF);

}



void draw() {
  background(0, 0, 0);
  light_button.Draw();
  power_button.Draw();


  if ((w!=width) || (h!=height)) {
    meterSetup();
    w = width;
    h = height;
    light_button.update(10, h - 100, w / 12, h / 15);
    power_button.update(light_button.x + light_button.w1 + 20, light_button.y, light_button.w1, light_button.h1);
  }
  float d = w * 0.7;
  image(video, 10, 10, d, (d * 9)/16);

if (millis() - tempTimer >= tempInterval) {
  
  if (port.available() > 0){
    String val = port.readString();
    String[] list = split(val, ",");
    if (list.length == 2 ) {
      if (abs(temp - float(list[0])) <= 25) {temp = float(list[0]);}
      if (abs(hum - float(list[1])) <= 25) {hum = float(list[1]);}
      
      tempMaxMin();

    }
  }
}
  m.updateMeter(int(temp));
  m2.updateMeter(int(hum));
  tempPrint();


 //delay(500);
  
}

void captureEvent(Capture video) {
  video.read();
  
}
