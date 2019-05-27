import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../model/user_model.dart';
import '../model/post_model.dart';

import 'package:flutter/foundation.dart';

import '../model/encryption.dart';

final _apiStartpoint = 'https://6da3b5c7.ngrok.io/api/employeestest';
final _apiExitpoint = 'https://6da3b5c7.ngrok.io/api/notify';

Future<List<UserModel>> fecthUserList(key) async {
  var keys = encryption.encrypt(key);
  print(keys);
  http.Response response = await http.get(Uri.encodeFull(_apiStartpoint),
      headers: {
        "Accept": "application/json",
        "client-signature": keys.toString()
      });

  if (response.statusCode != 200) {
    throw Exception('error getting users');
  }

  return compute(parseUsers, response.body);
}

List<UserModel> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<UserModel>((json) => UserModel.fromJSON(json)).toList();
}

Future<Post> createPost({Map body, key}) async {
  print(body);
  var keys = encryption.encrypt(key);
  return http.post(_apiExitpoint, body: body, headers: {
    "client-signature": keys.toString()
  }).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
