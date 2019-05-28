library my_prj.globals;

bool showSuportView = false;

String url = "http://160f4b82.ngrok.io/s";

String visitorOption1 = "Leverans";

String visitorOption2 = "Besökare";

String visitorOption3 = "Affärspartner";

String visitorOption4 = "Anställd";

String welcomeText = "Välkommen!";

String whoAreYou = "Vem är du?";

String whoAreYouLookingFor = "Vem söker du";

String unknown = "Jag vet inte vem jag söker";

String lastMessage = "Ring växel 0724340454";

String cancelText = "Avbryt";

const String emptyString = "";

const String defaultImage =
    "https://media.licdn.com/dms/image/C4D0BAQEFDQEvVnNIFQ/company-logo_200_200/0?e=2159024400&v=beta&t=rbi_4pyBeBBlPqqQaWMHUWOE9Q0vwIZV2iN_RS5fOWA";

const String defaultMessage = "någon på Meridium";

buildMessage(String name) {
  return "Vi kontaktar $name";
}
