void serialEvent(Serial p){
     String val = trim(p.readString());
     port.clear();
     p.clear();

    String[] list = split(val, ",");
    
    if (list.length == 9 ) {
     temp = float(list[0]);
     hum = float(list[1]);
     r = int(list[2]);
     g = int(list[3]);
     b = int(list[4]);
     if (int(list[5]) == 1) {lightStatus = true;}
     else {lightStatus = false;}
     if (int(list[6]) == 1) {powerStatus = false;}
     else {powerStatus = true;}
     if (int(list[7]) == 1) {fanStatus = true;}
     else {fanStatus = false;}
     if (int(list[8]) == 1) {heatStatus = true;}
     else {heatStatus = false;}
     
     buttonUpdate();

     tempMaxMin();
     redraw();

    }
  }
