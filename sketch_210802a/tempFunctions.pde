void tempMaxMin(){
  float averageTemp = 0;
  float averageHum = 0;
  textAlign(CENTER, CENTER);
  
  
  if (y.length < 5) {y = (float[])append(y, temp);}
  else {
    for ( int i = 0; i < 4; i++) {y[i+1] = y[i];}
    y[0] = temp;
    for (int i = 0; i < y.length; i++) {averageTemp += y[i];}
  
    averageTemp = averageTemp / y.length;
    if (abs(temp - averageTemp)/ averageTemp <= .10) {
        if (temp > maxTemp) {maxTemp = temp;}
        if (temp < minTemp) {minTemp = temp;}
  }
  }
  
  if (z.length < 5) {z = (float[])append(z, hum);}
  else {
    for ( int i = 0; i < 4; i++){z[i+1] = z[i];}
    z[0] = hum;

    for (int i = 0; i < z.length; i++) {averageHum += z[i];}
  
    averageHum = averageHum/z.length;
  
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
  int mx = m.getMeterX();
  int my = m.getMeterY();
  int mw = m.getMeterWidth();
  int mh = m.getMeterHeight();
  int my2 = m2.getMeterY();
  int mh2 = m2.getMeterHeight();

  textSize(24);
  fill(0, 0, 255);
  text(nf(temp, 0, 2), mx + (mw/2), (my+ mh - 25));
  
  
  textSize(12);
  text(nf(hum, 0, 2), mx + (mw/2), (my2+ mh2 - 12));
  
  textSize(18);

  fill(255,255,255);
  String s = "Min: " + minTemp + "  Max: " + maxTemp;
  text(s, mx + (mw/2), my + mh +10);

  String s2 = "Min: " + minHum + "  Max: " + maxHum;
  text(s2, mx + (mw/2), my2 + mh2 + 10);
}
