/*
 Error[13]
 sudo chmod a+rw /dev/ttyUSB0
*/

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
#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>

// Provide the token generation process info.
#include "addons/TokenHelper.h"
// Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Servo motor biblioteca
#include <Servo.h>
Servo myservo;

// Insert your network credentials
// MUDAR
#define WIFI_SSID "NOME_DO_WIFI"
#define WIFI_PASSWORD "SENHA_DO_WIFI"

// Insert Firebase project API Key
#define API_KEY "CHAVE_API_FIREBASE"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "URL_API_FIREBASE"

// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
bool signupOK = false;

void setup()
{
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", ""))
  {
    Serial.println("ok");
    signupOK = true;
  }
  else
  {
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  // servo
  myservo.attach(2);
}

/*
 *
 *
 *
 * Loop principal
 *
 *
 */
void loop()
{
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 5000 || sendDataPrevMillis == 0))
  {

    sendDataPrevMillis = millis();
    if (Firebase.RTDB.getBool(&fbdo, "plantas/0/regarPlanta"))
    {

      bool regarPlanta = fbdo.boolData();
      bool regando = false;

      // Mudar as parada
      if (regarPlanta)
      {
        regarPlanta = false;
        regando = true;

        // receber dado
        myservo.write(120);
        delay(1000);
        myservo.write(95);
        delay(1000);
        myservo.write(70);
        delay(1000);
        myservo.write(95);
        delay(1000);
      }

      // Escreve no banco
      if (Firebase.RTDB.setBool(&fbdo, "plantas/0/regarPlanta", regarPlanta))
      {
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());

        if (Firebase.RTDB.setBool(&fbdo, "plantas/0/regando", regando))
        {
          Serial.println("PASSED");
          Serial.println("PATH: " + fbdo.dataPath());
          Serial.println("TYPE: " + fbdo.dataType());
        }
        else
          Serial.println(fbdo.errorReason());
      }
      else
        Serial.println(fbdo.errorReason());
    }
    else
      Serial.println(fbdo.errorReason());
  }
}
