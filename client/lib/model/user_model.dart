class UserModel {
  final String name;

  UserModel({this.name});

  factory UserModel.fromJSON(parasedJSON) {
    return UserModel(name: parasedJSON["name"]);
  }
}
