void meterSetup() {

m = new Meter(this, width - (width / 4 + 25), 10, true);
  m.setMeterWidth(width/4);
  m.setArcMinDegrees(120);
  m.setArcMaxDegrees(420);
  m.setFrameStyle(2);
  m.setScaleOffsetFromPivotPoint(176);
  m.setTicMarkOffsetFromPivotPoint(115);
  m.setArcPositionOffset(135);
  m.setHighSensorWarningActive(true);
  m.setTitleFontSize(30);
  
  m.setPivotPointSize(20);
  m.setArcThickness(45);

  m.setDisplayMaximumNeedle(true);

  m.setMaximumNeedleThickness(5);
  m.setLongTicMarkLength(45);
  m.setLowSensorWarningValue(100);
  m.setHighSensorWarningValue(150);
  //m.setArcColor(#00FF00);
  
  m.setTitleFontColor(#0000FF);
  m.setPivotPointColor(#0000FF);
  m.setFrameColor(#0000FF);
  m.setMaximumNeedleColor(#FF0000);
  m.setLowSensorWarningArcColor(#00FF00);
  m.setMidSensorWarningArcColor(#0000FF);
  m.setHighSensorWarningArcColor(#FF0000);

  m.setTitle("Temp F");
  String[] scaleLabels = {"0", "20", "40", "60", "80", "100", 
    "120", "140", "160", "180", "200", "220", "240", "260"};
  m.setScaleLabels(scaleLabels);
  //m.setDisplayDigitalMeterValue(true);

  m.setMaxScaleValue(260);
  m.setMinInputSignal(0);
  m.setMaxInputSignal(260);

  int mx = m.getMeterX();
  int my = m.getMeterY();
  int mw = m.getMeterWidth();
  int mh = m.getMeterHeight();


  m2 = new Meter(this, mx, my + mh + 50);
  m2.setFrameStyle(2);
  m2.setMeterWidth(mw);
  m2.setTitle("Humidity");
  String[] scaleLabels2 = {"0", "10", "20", "30", "40", "50",
    "60", "70", "80", "90", "100"};
  m2.setScaleLabels(scaleLabels2);
  m2.setTitleFontSize(30);
  
  m2.setFrameStyle(2);
  m2.setScaleOffsetFromPivotPoint(176);
  m2.setTicMarkOffsetFromPivotPoint(115);
  m2.setArcPositionOffset(135);

  m2.setHighSensorWarningActive(true);
  m2.setLowSensorWarningValue(25);
  m2.setHighSensorWarningValue(75);
  
  m2.setDisplayMaximumNeedle(true);

  m2.setMaximumNeedleThickness(5);
  
  m2.setPivotPointSize(20);
  m2.setArcThickness(45);
  m2.setMinimumNeedleThickness(5);
  m2.setMaximumNeedleThickness(5);
  m2.setLongTicMarkLength(45);
  
  m2.setFrameColor(#0000FF);
  m2.setPivotPointColor(#0000FF);
  m2.setMaximumNeedleColor(#FF0000);
  m2.setLowSensorWarningArcColor(#0000FF);
  m2.setMidSensorWarningArcColor(#00FF00);
  m2.setHighSensorWarningArcColor(#FF0000);

  m2.setMaxScaleValue(100);
  m2.setMinInputSignal(0);
  m2.setMaxInputSignal(100);
  

 
}
