void tempMaxMin(){
  float averageTemp = 0;
  float averageHum = 0;

  
  
  if (y.length < 5) {y = (float[])append(y, temp);}
  else {
    for ( int i = 0; i < 4; i++) {y[i+1] = y[i];}
    y[0] = temp;
    for (int i = 0; i < 5; i++) {averageTemp += y[i];}
  
    averageTemp = averageTemp / 5;
    if (abs(temp - averageTemp)/ averageTemp <= .10) {
        if (temp > maxTemp) {maxTemp = temp;}
        if (temp < minTemp) {minTemp = temp;}
  }
  }
  
  if (z.length < 5) {z = (float[])append(z, hum);}
  else {
    for ( int i = 0; i < 4; i++){z[i+1] = z[i];}
    z[0] = hum;

    for (int i = 0; i < 5; i++) {averageHum += z[i];}
  
    averageHum = averageHum/5;
  
  //println("average temp: " + averageTemp + " " + y.length);
 // println("average Humidity: " + averageHum + " " + z.length);  
  
    if (abs(hum - averageHum) / averageHum <= .10) {
        if (hum > maxHum) {maxHum = hum;}
        if (hum < minHum) {minHum = hum;}
      }
  }
}

void tempPrint() {
  textAlign(CENTER, CENTER);
  float my = (height * 3) / 16;
  float mh = width / 2;
  float my2 = (height * 17) / 32;



  
  if (temp > 200) {fill(255, 0, 0);}
    else if (temp > 175) {fill(255, 127, 0);}
    else if (temp > 150) {fill(255, 255, 0);}
    else {fill(0, 0, 255);}
  
  textAlign(CENTER, CENTER); 
  textSize(height / 5);
  text(nf(temp, 0, 2), mh, my);
  float tAsc  = textAscent();
  float tDes = textDescent();
  float tHeight = tAsc - tDes;
  
    textSize(height / 10);
  textAlign(CENTER, BOTTOM);  
  fill(0, 0, 0);
  text("TEMPERATURE", mh, my - (tHeight / 2));

  
  if (hum > 95) {fill(255, 0, 0);}
    else if (hum > 85) {fill(255, 127, 0);}
    else if (hum > 75) {fill(255, 255, 0);}
    else {fill(0, 0, 255);}

  textAlign(CENTER, CENTER);   
  text(nf(hum, 0, 2), mh, my2);
  float hAsc  = textAscent();
  float hDes = textDescent();
  float hHeight = hAsc - hDes;
  textSize(height / 15);
  
  
  
  fill(0, 0, 0);
  textAlign(CENTER, BOTTOM);  
  text("HUMIDITY", mh, my2 - (hHeight /2));

  textSize(height / 25);

  textAlign(CENTER, TOP);
  fill(0, 0, 0);
  String s = "Min: " + minTemp + "  Max: " + maxTemp;

  text(s, mh, my + tHeight);  

  String s2 = "Min: " + minHum + "  Max: " + maxHum;

  text(s2, mh, my2 + hHeight);
  
  stroke(r, g, b);
  strokeWeight(10);
}
