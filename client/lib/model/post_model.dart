import '../config/globals.dart' as globals;

class Post {
  final String name;
  final String visitor;
  final String channelId;
  final String userId;

  Post(
      {this.name = globals.emptyString,
      this.visitor = globals.emptyString,
      this.channelId = globals.emptyString,
      this.userId = globals.emptyString});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        name: json['name'],
        visitor: json['visitor'],
        channelId: json['channelId'],
        userId: json['userId']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["visitor"] = visitor;
    map["channelId"] = channelId;
    map["userId"] = userId;
    return map;
  }
}
