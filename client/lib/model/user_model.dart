class UserModel {
  final String name;
  final String userId;
  final String image;
  final String channels;

  UserModel({
    this.name,
    this.userId,
    this.channels,
    this.image,
  });

  factory UserModel.fromJSON(Map<String, dynamic> parsedJSON) {
    return UserModel(
        userId: parsedJSON["id"],
        name: parsedJSON["real_name"],
        image: parsedJSON["images"]["pic"],
        channels: parsedJSON["channels"][0]);
  }
}
