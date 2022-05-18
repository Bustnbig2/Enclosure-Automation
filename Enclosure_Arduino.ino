//5.17.2022

#include <DHT.h>
#include <DHT_U.h>
#define DHTTYPE DHT22

byte eStop = 2;
byte lswitchPin = 5;
byte pswitchPin = 6;
byte printerRunning = 8;
byte redPin = 9;
byte greenPin = 10;
byte bluePin = 11;
byte tempPin = 12;
byte receivePin = 13;

byte lightPin = A0;
byte powerPin = A1;


int redNum = 0;
int greenNum = 255;
int blueNum = 255;
int redSend = 0;
int greenSend = 255;
int blueSend = 255;
int blinkCount = 0;
boolean lTrigger = LOW;
boolean pTrigger = LOW;
boolean ledState = LOW;
boolean blinkOn = LOW;
boolean warningIndicator = LOW;
float tempF = 0;
float humidity = 0;
const long blinkinterval = 2000;
const long tempInterval = 2100;
const long sendInterval = 2100;
const long eStopInterval = 250;
const long lightInterval = 100;
const long powerInterval = 1000;
const long blinkMax = 500;
const long endInterval = 300000;
unsigned long previousMillis = 0;
unsigned long tempMillis = 0;
unsigned long lightMillis = 0;
unsigned long powerMillis = 0;
unsigned long sendMillis = 0;
unsigned long eStopMillis = 0;

DHT dht(tempPin, DHTTYPE);

void setup() {

	Serial.begin(115200);

	pinMode(redPin, OUTPUT);
	pinMode(greenPin, OUTPUT);
	pinMode(bluePin, OUTPUT);
	pinMode(lightPin, OUTPUT);
	pinMode(lswitchPin, INPUT_PULLUP);
	pinMode(powerPin, OUTPUT);
	pinMode(pswitchPin, INPUT_PULLUP); 
	pinMode(receivePin, OUTPUT);
	pinMode(printerRunning, INPUT_PULLUP);
	pinMode(eStop, INPUT);
	digitalWrite(lightPin,LOW);
	digitalWrite(powerPin, LOW);
	digitalWrite(receivePin, LOW);
	
	lightColor(redNum,greenNum,blueNum);
	
	dht.begin();
	
}
void loop() {
	
	readTemp();
	compSwitch();
	recieveBlink();
	
	if (digitalRead(printerRunning) == HIGH) {machineRunning(0);}
	else {machineRunning(1);}
	
	if (blinkOn == HIGH) {digitalWrite(receivePin, HIGH);}
	else {digitalWrite(receivePin, LOW);}
	
	if (digitalRead(eStop) == LOW) {
		eStopMillis = millis();
		}
		
	if (millis() - eStopMillis >= eStopInterval) {
		emergency(4);
		}
	
	if (digitalRead(pswitchPin) == HIGH){
		powerMillis = millis();
		pTrigger = LOW;
		}
	
	if (millis() - powerMillis >= powerInterval){
		if (digitalRead(pswitchPin) == HIGH) {pTrigger = LOW;}
		else {
			machineRunning(4);
			endTimer();
			}
		}
	
	if (digitalRead(lswitchPin) == HIGH){
		lightMillis = millis();
		lTrigger = LOW;
		}
	
	if (millis() - lightMillis >= lightInterval){
		if (digitalRead(lswitchPin) == HIGH) {lTrigger = LOW;}
		else {lTrigger = HIGH;}
		}
	
	tempAnalysis();

	if (lTrigger == LOW){digitalWrite(lightPin, LOW);}
	else {digitalWrite(lightPin, HIGH);}
	
	if (pTrigger == LOW){digitalWrite(powerPin, LOW);}
	else {digitalWrite(powerPin, HIGH);}

}

void readTemp(){
	unsigned long ctempMillis = millis();
	if (ctempMillis - tempMillis >= tempInterval) {
		tempF = dht.readTemperature(true);
		humidity = dht.readHumidity();
		tempMillis = ctempMillis;
		sendSerial(redSend,greenSend,blueSend);
	}
	
}

void tempAnalysis(){
	if (tempF > 200){emergency(1);}
	else if (tempF > 175){emergency(2);}
	else if (warningIndicator == HIGH){emergency(2);}
	else if (tempF > 150){emergency(3);}
	else {lightColor(redNum, greenNum, blueNum);}
}


void emergency(int x){
	if (x == 1){
		while (tempF >= 150) {
			digitalWrite(lightPin, LOW);
			digitalWrite(powerPin, HIGH);
			lightColor(255,0,0);
			readTemp();
		}
	}
	if (x == 2){
		blinkColor(255,0,0,255,255,0);
	}
	if (x == 3) {
		lightColor(255,255,0);
	}
	if (x == 4){
		while (1) {
			digitalWrite(lightPin, LOW);
			digitalWrite(powerPin, HIGH);
			blinkColor(255,0,0,255,255,255);
		}
	}
}

void blinkColor(int R, int G, int B,int R2, int G2, int B2){
unsigned long currentMillis = millis();
	if (currentMillis - previousMillis >= blinkinterval) {
		if (ledState == LOW) {ledState = HIGH;} 
		else {ledState = LOW;}
		previousMillis = currentMillis;
	}
	if (ledState == LOW) {lightColor(R2,G2,B2);
	}
	else {lightColor(R,G,B);
	}

}

void compSwitch(){

	// Serial receive 5 to E-Stop;	
	
	int val=0;
	if (Serial.available() > 0){
	val=Serial.read();

	if (val == 53){	//#5
		blinkOn = HIGH;
		emergency(4);
	}
	val = 0;
	}
	
}

void recieveBlink () {
	if (blinkOn == HIGH) {blinkCount++;}
	if (blinkOn == LOW) {blinkCount = 0;}
	
	if (blinkCount >= blinkMax) {
		blinkOn = LOW;
		blinkCount = 0; 
	}
}

void lightColor(int R, int G, int B){

	analogWrite(redPin, R);
	analogWrite(greenPin, G);
	analogWrite(bluePin, B);
	redSend = R; greenSend = G; blueSend = B;
}

void machineRunning(int x){
	if (x == 0) {
		redNum = 0; 
		greenNum = 255; 
		blueNum = 255; 
	}
	else if (x == 1) {
		redNum = 0;
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

void sendSerial(int R, int G, int B){
	unsigned long currentMillis = millis();
	if (currentMillis - sendMillis >= sendInterval) {
		Serial.print(tempF); Serial.print(","); Serial.print(humidity);
		Serial.print(",");Serial.print(R); Serial.print(","); 
		Serial.print(G); Serial.print(","); Serial.print(B);
		Serial.print(","); Serial.print(lTrigger, DEC); Serial.print(",");
		Serial.print(pTrigger, DEC); Serial.print(","); Serial.print(0, DEC); 
		Serial.print(","); Serial.println(0, DEC);
		sendMillis = currentMillis;
	}
}

void endTimer(){
	unsigned long endMillis = millis();
		while (millis() - endMillis < endInterval) {
			readTemp();
			tempAnalysis();
			blinkColor(0,0,255,255,0,255);
		}
		while (1) {
			lTrigger = LOW;
			digitalWrite(lightPin, LOW);
			pTrigger = HIGH;
			digitalWrite(powerPin, HIGH);
			blinkColor(255,0,0,0,0,255);
		}
}
