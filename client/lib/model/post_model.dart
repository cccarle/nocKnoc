class Post {
  final String name;
  final String visitor;
  final String channelId;

  Post({this.name, this.visitor, this.channelId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        name: json['name'],
        visitor: json['visitor'],
        channelId: json['channelId']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["visitor"] = visitor;
    map["channelId"] = channelId;
    return map;
  }
}
