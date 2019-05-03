import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../model/user_model.dart';
import '../model/post_model.dart';

import 'package:flutter/foundation.dart';

final _apiEndpoint = "https://jsonplaceholder.typicode.com/users";
final _apiExitpoint = "http://webhook.site/8320d5c3-c0da-471e-8953-3391ca3c9b7e";
// final _apiEndpoint = "https://randomuser.me/api/";

Future<List<String>> fecthUserList() async {
  http.Response response = await http.get(Uri.encodeFull(_apiEndpoint),
      headers: {"Accept": "application/json"});

  if (response.statusCode != 200) {
    throw Exception('error getting users');
  }

  return compute(parseUsers, response.body);
}

List<String> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<String>((json) => UserModel.fromJSON(json).name).toList();
}

Future<Post> createPost({Map body}) async {
  return http.post(_apiExitpoint, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}

 