import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'dart:async';

final _root = 'URL_TO_API';

class Api {
  Future<List> fecthUserList() async {
    List users = [];
    var response = await get('https://jsonplaceholder.typicode.com/users');
    var decodedJson = json.decode(response.body);
    decodedJson.forEach((res) => {users.add(UserModel.fromJSON(res).name)});

    return users;
  }
}
