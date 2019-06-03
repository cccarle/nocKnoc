import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';

//Models
import '../model/user_model.dart';
import '../model/post_model.dart';
import '../model/encryption.dart';
// Config
import '../config/globals.dart' as globals;

final _fetchUserListURL = '${globals.url}/api/employees';
final _postToAPIURL = '${globals.url}/api/notify';

Future<List<UserModel>> fecthUserList(key) async {
  var keys = encryption.encrypt(key);
  http.Response response = await http.get(
    Uri.encodeFull(_fetchUserListURL),
    headers: {
      "Accept": "application/json",
      "client-signature": keys.toString()
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Error getting users');
  }

  return compute(parseUsers, response.body);
}

List<UserModel> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<UserModel>((json) => UserModel.fromJSON(json)).toList();
}

Future<Post> createPost({Map body, key}) async {
  var keys = encryption.encrypt(key);
  print(body);
  return http.post(_postToAPIURL,
      body: body, headers: {"client-signature": keys.toString()}).then(
    (http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Error while posting");
      }
    },
  );
}
