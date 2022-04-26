//7.23.2021

#include <DHT.h>
#include <DHT_U.h>
#define DHTTYPE DHT22


byte receivePin = 13;
byte bluePin = 12;
byte greenPin = 11;
byte redPin = 10;
byte tempPin = 9;
byte lightPin = 4;
byte lswitchPin = 2;
byte powerPin = 5;
byte pswitchPin = 3;
byte endswitch = 7;

int redNum = 0;
int greenNum = 255;
int blueNum = 255;
int blinkCount = 0;
volatile boolean lTrigger = LOW;
boolean pTrigger = LOW;
boolean powerCount = HIGH;
boolean endCount = HIGH;
boolean ledState = LOW;
boolean blinkOn = LOW;
boolean pRunning = LOW;
float tempF = 0;
float minTemp = 200;
float maxTemp = 0;
float humidity = 0;
float minHumidity = 100;
float maxHumidity = 0;
const long blinkinterval = 500;
const long tempInterval = 2100;
const long lightInterval = 1000;
const long powerInterval = 5000;
const long endInterval = 5000;
const long blinkMax = 500;
unsigned long previousMillis = 0;
unsigned long tempMillis = 0;
unsigned long lightMillis = 0;
unsigned long powerMillis = 0;
unsigned long endStopMillis = 0;
 

DHT dht(tempPin, DHTTYPE);



void setup() {

  Serial.begin(115200);
  // Serial.print("Sketch:   ");   Serial.println(__FILE__);
  // Serial.print("Uploaded: ");   Serial.println(__DATE__);
  // Serial.println(" ");
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  pinMode(lightPin, OUTPUT);
  pinMode(lswitchPin, INPUT);
  pinMode(powerPin, OUTPUT);
  pinMode(pswitchPin, INPUT); 
  pinMode(endswitch, INPUT);
  pinMode(receivePin, OUTPUT);
  digitalWrite(lightPin,LOW);
  digitalWrite(powerPin, LOW);
  digitalWrite(receivePin, LOW);
  attachInterrupt (digitalPinToInterrupt(lswitchPin),interuptlTrigger,RISING);
  //attachInterrupt (digitalPinToInterrupt(pswitchPin),interuptpTrigger,RISING);
  // Serial.println("Enter 1 for ?");
  // Serial.println("Enter 2 to switch light");
  // Serial.println("Enter 3 to switch power"); 
  // Serial.println("Enter 4 machine is running");
  // Serial.println("Enter 5 to End");  
  lightColor(redNum,greenNum,blueNum);
  dht.begin();
  
}

void loop() {
  readTemp();
  compSwitch();
  recieveBlink () ;
  
  
  if (blinkOn == HIGH) {digitalWrite(receivePin, HIGH);}
  else {digitalWrite(receivePin, LOW);}

  
  if (digitalRead(pswitchPin) == LOW){
    powerMillis = millis();
    if (pRunning == HIGH) {machineRunning(1);}
    else {machineRunning(0);}
  }
  else {machineRunning(4);}
  
  
  if (digitalRead(endswitch) == LOW){
    endStopMillis = millis();
    pRunning = HIGH;
    }
  
  if (millis() - powerMillis >= powerInterval){
    if (powerCount == HIGH) {interuptpTrigger();}
    powerCount = LOW;
    }
  else {powerCount = HIGH;}
  
  if ((millis() - endStopMillis >= endInterval) && (pRunning == HIGH)) {
    if (endCount == HIGH) {endTimer(18000);
    pRunning = LOW;
    }
    endCount = LOW;
    
    }
  else {endCount = HIGH;} 

  
  if (tempF > 200){emergency(1);}
  else if (tempF > 175){emergency(2);}  
  else if (tempF > 150){emergency(3);}
  else {lightColor(redNum, greenNum, blueNum);}

  if (lTrigger == LOW){digitalWrite(lightPin, LOW);}
  else{digitalWrite(lightPin, HIGH);}
  
  if (pTrigger == LOW){digitalWrite(powerPin, LOW);}
  else{digitalWrite(powerPin, HIGH);}

}

void interuptlTrigger(){
  unsigned long ltempMillis = millis();
  if (ltempMillis  - lightMillis >= lightInterval) {
    if (lTrigger == LOW){lTrigger = HIGH;}
    else{lTrigger = LOW;}
    lightMillis = ltempMillis;
  }
}

void interuptpTrigger(){
    if (pTrigger == LOW){pTrigger = HIGH;}
    else{pTrigger = LOW;}
    }

void compSwitch(){
  int val=0;
  if(Serial.available() > 0){
  val=Serial.read();

  // if (val == 49){  //#1
    // Reserved
    // blinkOn = HIGH;
  // }
  if (val == 50){   //#2
    interuptlTrigger();
    blinkOn = HIGH;
  }
  if (val == 51){   //#3
    interuptpTrigger();
    blinkOn = HIGH;
  }
  if (val == 52){   //#4
   machineRunning(4);
   pRunning = HIGH;
   blinkOn = HIGH;
  }
  if (val == 53){   //#5
    endTimer(18000);
    blinkOn = HIGH;
  }
  val = 0;
  }
  
}

void readTemp(){
  unsigned long ctempMillis = millis();
  if (ctempMillis - tempMillis >= tempInterval) {
    tempF = dht.readTemperature(true);
    humidity = dht.readHumidity();
    if (tempF  < minTemp) {minTemp = tempF;}
    if (tempF  > maxTemp) {maxTemp = tempF;}
    if (humidity < minHumidity) {minHumidity = humidity;}
    if (humidity > maxHumidity) {maxHumidity = humidity;}
    tempMillis = ctempMillis;
    Serial.print(tempF); Serial.print(","); Serial.println(humidity);
  }
  
}

void emergency(int x){
  if (x == 1){
    while (tempF >= 250) {
      digitalWrite(lightPin, LOW);
      digitalWrite(powerPin, LOW);
      lightColor(255,0,0);
    }
  }
  if (x == 2){
    blinkColor(255,0,0,255,255,0);
    }
  if (x == 3) {
    lightColor(255,255,0);
    }
}

void blinkColor(int R, int G, int B,int R2, int G2, int B2){
unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= blinkinterval) {
    if (ledState == LOW) {
      ledState = HIGH;
    } 
    else {
      ledState = LOW;
    }
    previousMillis = currentMillis;
  }
  if (ledState == LOW) {
    lightColor(R2,G2,B2);
  }
  else {
    lightColor(R,G,B);
  }

}

void lightColor(int R, int G, int B){

  analogWrite(redPin, R);
  analogWrite(greenPin, G);
  analogWrite(bluePin, B);
}

void endTimer(long x){
  unsigned long endMillis = millis();
    while (millis() - endMillis < x) {
      blinkColor(0,0,255,255,0,255);
    }
  lTrigger = LOW;
  pTrigger = HIGH;
  pRunning = LOW;
}

void recieveBlink () {
  if (blinkOn == HIGH) {blinkCount++;}
  if (blinkOn == LOW) {blinkCount = 0;}
  
  if (blinkCount >= blinkMax) {
    blinkOn = LOW;
    blinkCount = 0; 
  }
}

void machineRunning(int x){
  if (x == 0) {
       redNum = 0;
     greenNum = 255;
     blueNum = 255;
  }
  else if (x == 1) {
    redNum = 0;
    greenNum = 0;
    blueNum = 255;
  }
    else if (x == 3) {
    redNum = 255;
    greenNum = 255;
    blueNum = 0;
  }
    else if (x == 4) {
    redNum = 255;
    greenNum = 0;
    blueNum = 0;
  }
   else {
    redNum = 255;
    greenNum = 255;
    blueNum = 255;
  }
}
