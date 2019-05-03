class Post {
  final String user;

  Post(this.user);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user: json['user'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = user;
    return map;
  }
}