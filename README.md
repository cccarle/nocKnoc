# nocKnoc

[Dokumentation](https://github.com/cccarle/nocKnoc/wiki)

# Server

## Förkrav
Ett slack-workspace med en App med bot-funktionalitet
I inställningar för boten på slack kommer en URL att tas emot. Denna url behöver vara den utgående adressen till servern.
## Tillvägagångssätt
* Skapa en app i Slack. [Instruktioner](Thisisnotalink.asdfdsasd)
* Ladda ner repot
* Installera beroende npm-paket 
* I en .env-fil lokaliserat i serverns rot behövs följande:
```
Bot_User_OAuth_Access_Token=”Bot token tilldelad av appen i slack”
User_OAuth_Access_Token=”User token tilldelad av appen i slack”
slack_signing_secret=”Secret för boten given av slack”
client_signature=”En överenskommen hemlighet delad med klientsidan”
```
Starta servern med kommandot “node index” stående i serverns rot

# Klient

## Tillvägagångssätt

* Installera Android studio
* [Installera](https://github.com/cccarle/nocKnoc/wiki/Flutter-Installation) Flutter
* Skapa en Android/IOS emulator via Android studio
* Ladda ner repotsitoriet
* Skapa fil “dev.json” i “env” mappen, i denna i filen behövs följande
```
 "env": "DEV",
 "production": false,
 "apiKey": <Samma key som client_signature på servern>
```
* När detta är gjort skriv följande kommando i klientens rot:
* ```Flutter packages pub run build_runner build --delete-conflicting-outputs```
* Starta programmet med debugger på vald IDE
