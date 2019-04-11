class UserModel {
  final String name;
  UserModel({this.name});

  // named constructor
  factory UserModel.fromJSON(Map<String, dynamic> parasedJSON) {
    return UserModel(name: parasedJSON["name"]);
  }
}
