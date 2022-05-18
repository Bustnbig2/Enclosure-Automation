class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w1;    // width of button
  float h1;    // height of button
  float r1;   // button radius
  int bColor; 
  int bOutline;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, float radiusB, int buttonColor, int buttonOutline) {
    label = labelB;
    x = xpos;
    y = ypos;
    w1 = widthB;
    h1 = heightB;
    r1 = radiusB;
    bColor = buttonColor;
    bOutline = buttonOutline;
  }
  
  void Draw() {
    fill(bColor);
    stroke(bOutline);
    strokeWeight(4);
    textSize(width / 15);
    rectMode(CENTER);
    rect(x, y, w1, h1, r1);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x, y);
    strokeWeight(1);
  }
  
  void update(float xpos, float ypos, float widthB, float heightB, float radiusB, int buttonColor, int buttonOutline) {
    x = xpos; 
    y = ypos; 
    w1 = widthB; 
    h1 = heightB;
    r1 = radiusB;
    bColor = buttonColor;
    bOutline = buttonOutline;
  } 
  
  boolean MouseIsOver() {
    if (mouseX >= (x - (w1 / 2)) && mouseX <= (x + (w1 / 2)) &&
    mouseY >= (y - (h1 / 2)) && mouseY <= (y + (h1 / 2))) {    
      return true;
    }
    else {return false;}
  }
}

void mousePressed(){
  if (power_button.MouseIsOver()) {
    if (powerStatus){
      int dialogResult =
      JOptionPane.showConfirmDialog(null, "Are You Sure", 
      "Turning the printer off is dangerous", JOptionPane.YES_NO_OPTION);

    if (dialogResult == JOptionPane.YES_OPTION){port.write("5");}
    }
    else {port.write("3");}
  }
}

void buttonUpdate() {

 float bx = width / 2;
 float by = (height * 7) / 8;
 float bw = width * 0.8;
 float bh = height / 6;
 float br = width /10;

 
  power_button = new Button("EMERGENCY STOP", bx, by, 
      bw, bh, br, #FF0000, color(r, g, b));
      
}

void buttonLight() {
   float infoX = width / 5;
   float infoY = (height * 23) / 32;
   float infoHeight = height /12;
   float infoWidth = width / 8;
   float infoRadius = width /20;

   strokeWeight(height / 225);
   stroke(color(r, g, b));
   rectMode(CENTER);  
   textSize(width / 35); 
   textAlign(CENTER, CENTER);
   
  if (lightStatus) {
    fill(#00F4FF);
    rect(infoX, infoY, infoWidth, infoHeight, infoRadius);
    fill(0);
    text("LIGHT", infoX, infoY);
    }
 else {
    fill(#000000);
    rect(infoX, infoY, infoWidth, infoHeight, infoRadius);
    fill(#FFFFFF);
    text("LIGHT", infoX, infoY);
    }
    
 if (powerStatus) {
    fill(#00FF00);
    rect(infoX * 2, infoY, infoWidth, infoHeight, infoRadius);
    fill(0);
    text("POWER", infoX * 2, infoY);
    }
 else {
    fill(#000000);
    rect(infoX * 2, infoY, infoWidth, infoHeight, infoRadius);
    fill(#FFFFFF);
    text("POWER", infoX * 2, infoY);
 }
  if (fanStatus) {
    fill(#00FF00);
    rect(infoX * 3, infoY, infoWidth, infoHeight, infoRadius);
    fill(0);
    text("FAN", infoX * 3, infoY);
    }
 else {
    fill(#000000);
    rect(infoX * 3, infoY, infoWidth, infoHeight, infoRadius);
    fill(#FFFFFF);
    text("FAN", infoX * 3, infoY);
 }   
   if (heatStatus) {
    fill(#00FF00);
    rect(infoX * 4, infoY, infoWidth, infoHeight, infoRadius);
    fill(0);
    text("HEAT", infoX * 4, infoY);
    }
 else {
    fill(#000000);
    rect(infoX * 4, infoY, infoWidth, infoHeight, infoRadius);
    fill(#FFFFFF);
    text("HEAT", infoX * 4, infoY);
 }     
}
