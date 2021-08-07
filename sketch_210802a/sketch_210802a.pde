//jBruening
// 8/3/21


import processing.serial.*;
import meter.*;

Meter m;
Meter m2;
Button light_button;
Button power_button;



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

void setup() {
  size(955, 600);
  background(0, 0, 0);
  textSize(12);
  surface.setResizable(true);

  port = new Serial(this, "COM4", 115200);

  meterSetup();
 
  light_button = new Button("Light", m.getMeterX(), height - 65, width / 12, height / 19.1, #03BEFF, #0000FF);
  power_button = new Button("Power", light_button.x + m.getMeterWidth() - light_button.w1, 
      light_button.y, light_button.w1, light_button.h1, #FF0000, #0000FF);

}
void draw() {
  background(0, 0, 0);
  light_button.Draw();

  if ((w!=width) || (h!=height)) {
    meterSetup();
    w = width;
    h = height;
    light_button.update(m.getMeterX(), h - 65, w / 12, h / 19.1);
    power_button.update(light_button.x + m.getMeterWidth() - light_button.w1, light_button.y, light_button.w1, light_button.h1);
  }

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


 delay(500);
  
}
