class UserModel {
  String url;

  UserModel(this.url);

  // named constructor
  UserModel.fromJSON(Map<String, dynamic> parasedJSON) {
    url = parasedJSON["name"];
  }
}
