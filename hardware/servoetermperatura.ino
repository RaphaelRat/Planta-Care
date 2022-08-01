#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <DHT.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#include <Servo.h>


#define DHTTYPE DHT11
#define DHTPIN 2
#define WIFI_SSID "NOME_DO_WIFI"
#define WIFI_PASSWORD "SENHA_DO_WIFI"
#define API_KEY "CHAVE_API_FIREBASE"
#define DATABASE_URL "URL_API_FIREBASE" 

void plantaCare_sendTemperature();
void plantaCare_sendHumidity();

Servo myservo;
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
DHT dht(DHTPIN, DHTTYPE);
unsigned long sendDataPrevMillis = 0;
bool signupOK = false;

void setup(){
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Conectando ao Wi-Fi...");
  while (WiFi.waitForConnectResult() != WL_CONNECTED);
  Serial.println(" [OK]");
  
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  Serial.print("Conectando-se com o Firebase...");
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println(" [OK]");
    signupOK = true;     
    }
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  // servo
  myservo.attach(16);
}
void loop(){
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 1000 || sendDataPrevMillis == 0))
    Serial.println("Entrou no primeiro if [OK]");
    sendDataPrevMillis = millis();
    plantaCare_sendTemperature();
    if(Firebase.RTDB.getBool(&fbdo, "plantas/0/regarPlanta")){
      bool regarPlanta = fbdo.boolData();
      bool regando = false;
      if(regarPlanta){
        Serial.println(" RegarPlanta [OK]");
        regando = true;
        //receber dado
        myservo.write(120);
        delay(1000);
        myservo.write(95);
        delay(1000);
        myservo.write(70);
        delay(1000);
        myservo.write(95);
        delay(1000);
        regarPlanta = false;
      }

      // Escreve no banco
      if(Firebase.RTDB.setBool(&fbdo, "plantas/0/regarPlanta", regarPlanta)){
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());

        if(Firebase.RTDB.setBool(&fbdo, "plantas/0/regando", regando)){
          Serial.println("PASSED");
          Serial.println("PATH: " + fbdo.dataPath());
          Serial.println("TYPE: " + fbdo.dataType());
        }
        else Serial.println(fbdo.errorReason());
      }
      else Serial.println(fbdo.errorReason());
    }
    else Serial.println(fbdo.errorReason());
  }


void plantaCare_sendTemperature()
{
  Serial.println(" SendTemperature [OK]");
  float temperature = dht.readTemperature();
  Firebase.RTDB.setFloat(&fbdo, "plantas/0/temperaturaAmb", temperature);
  Firebase.RTDB.setFloat(&fbdo, "plantas/1/temperaturaAmb", temperature);
  Firebase.RTDB.setFloat(&fbdo, "plantas/2/temperaturaAmb", temperature);
}
