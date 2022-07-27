/*
  Rui Santos
  Complete project details at our blog.
    - ESP32: https://RandomNerdTutorials.com/esp32-firebase-realtime-database/
    - ESP8266: https://RandomNerdTutorials.com/esp8266-nodemcu-firebase-realtime-database/
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files.
  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
  Based in the RTDB Basic Example by Firebase-ESP-Client library by mobizt
  https://github.com/mobizt/Firebase-ESP-Client/blob/main/examples/RTDB/Basic/Basic.ino
*/

#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <DHT.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define DHTTYPE DHT11
#define DHTPIN 2
#define HS1PIN 3
#define HS2PIN 4
#define HS3PIN 5
#define WIFI_SSID "NOME_DO_WIFI"
#define WIFI_PASSWORD "SENHA_DO_WIFI"
#define API_KEY "CHAVE_API_FIREBASE"
#define DATABASE_URL "URL_API_FIREBASE" 

void plantaCare_sendTemperature(float temperature);
void plantaCare_sendHumidity();

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
DHT dht(DHTPIN, DHTTYPE);
unsigned long sendDataPrevMillis = 0;

void setup()
{
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Conectando ao Wi-Fi...");
  while (WiFi.waitForConnectResult() != WL_CONNECTED);
  Serial.println(" [OK]");

  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  Serial.print("Conectando-se com o Firebase...");
  if (Firebase.signUp(&config, &auth, "", ""))
    Serial.println(" [OK]");
  else
  {
    Serial.println(" [ERRO]");
    Serial.printf("%s", config.signer.signupError.message.c_str());
    while(1);
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop()
{
  if (Firebase.ready() && (millis() - sendDataPrevMillis > 1000 || sendDataPrevMillis == 0))
  {
    sendDataPrevMillis = millis();
    plantaCare_sendTemperature();
  }
}
void plantaCare_sendTemperature()
{
  float temperature = dht.readTemperature();
  Firebase.RTDB.setFloat(&fbdo, "plantas/0/temperaturaAmb", temperature);
  Firebase.RTDB.setFloat(&fbdo, "plantas/1/temperaturaAmb", temperature);
  Firebase.RTDB.setFloat(&fbdo, "plantas/2/temperaturaAmb", temperature);
}
void plantaCare_sendHumidity()
{
  Firebase.RTDB.setFloat(&fbdo, "plantas/0/umidadeSolo", analogRead(HS1PIN));
  Firebase.RTDB.setFloat(&fbdo, "plantas/1/umidadeSolo", analogRead(HS2PIN));
  Firebase.RTDB.setFloat(&fbdo, "plantas/2/umidadeSolo", analogRead(HS3PIN));
}

