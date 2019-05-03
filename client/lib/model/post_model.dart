class Post {
  final String user;
  final String visitor;

  Post({this.user, this.visitor});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user: json['user'],
      visitor: json['visitor']
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = user;
    map["visitor"] = visitor;
    return map;
  }
}