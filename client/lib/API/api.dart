import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../model/user_model.dart';

import 'package:flutter/foundation.dart';

final _apiEndpoint = "https://jsonplaceholder.typicode.com/users";

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
