# nocKnoc

[Dokumentation](https://github.com/cccarle/nocKnoc/wiki)

## Server

### Förkrav
Ett slack-workspace med en App med bot-funktionalitet
I inställningar för boten på slack kommer en URL att tas emot. Denna url behöver vara den utgående adressen till servern. 
### Tillvägagångssätt
* Ladda ner repot
* Installera beroende npm-paket 
* I en .env-fil lokaliserat i serverns rot behövs följande:
´´´Bot_User_OAuth_Access_Token=”Bot token tilldelad av appen i slack”
User_OAuth_Access_Token=”User token tilldelad av appen i slack”
slack_signing_secret=”Secret för boten given av slack”
client_signature=”En överenskommen hemlighet delad med klientsidan”
Starta servern med kommandot “node index” stående i serverns rot
