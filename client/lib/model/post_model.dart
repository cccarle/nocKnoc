class Post {
  final String user;
  final String visitor;
  // final int userId;
  // final int chanelId;

  Post({this.user, this.visitor/*, this.userId*/});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user: json['user'],
      visitor: json['visitor'],
      /*userId: json['userId'],*/
      /*chanelId: json['channelId'] */
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = user;
    map["visitor"] = visitor;
    /*map["userId"] = userId;
    map["chanelId"] = chanelId; */
    return map;
  }
}