// 5/18/22

import javax.swing.JOptionPane;
import processing.serial.*;

Button power_button;

Serial port;

float minTemp = 260;
float maxTemp = 0;
float minHum = 100;
float maxHum = 0;
float temp = 0;
float hum = 0;
float[] y = new float[0];
float[] z = new float[0];
int r = 0;
int g = 0;
int b = 0;
boolean lightStatus = false;
boolean powerStatus = false;
boolean fanStatus = false;
boolean heatStatus = false;

void setup() {
  size(450, 450);
  background(227, 227, 227);
  textSize(12);
  surface.setResizable(true);
  noLoop();
  //printArray(Capture.list());

 port = new Serial(this, "COM3", 115200);
 port.bufferUntil(10);
  
  

 float bx = width / 2;
 float by = (height * 7) / 8;
 float bw = width * 0.8;
 float bh = height / 6;
 float br = width /10;
  

  power_button = new Button("EMERGENCY STOP", bx, by, 
      bw, bh, br, #FF0000, color(r, g, b));


}



void draw() {
  
     background(227, 227, 227);
     power_button.Draw();
     buttonLight();
  

     tempPrint();
}
