class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w1;    // width of button
  float h1;    // height of button
  int bColor; 
  int bOutline;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, int buttonColor, int buttonOutline) {
    label = labelB;
    x = xpos;
    y = ypos;
    w1 = widthB;
    h1 = heightB;
    bColor = buttonColor;
    bOutline = buttonOutline;
  }
  
  void Draw() {
    fill(bColor);
    stroke(bOutline);
    strokeWeight(4);
    textSize(20);
    rect(x, y, w1, h1, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w1 / 2), y + (h1 / 2));
    strokeWeight(1);
  }
  
  void update(float xpos, float ypos, float widthB, float heightB) {
    x = xpos; 
    y = ypos; 
    w1 = widthB; 
    h1 = heightB;
  } 
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w1) && mouseY > y && mouseY < (y + h1)) {
      return true;
    }
    return false;
  }
}

void mousePressed(){
  if (light_button.MouseIsOver()) {port.write("2");}    
  if (power_button.MouseIsOver()) {port.write("3");}

  }
  
