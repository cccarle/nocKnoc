import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../model/user_model.dart';

final _apiEndpoint = "https://jsonplaceholder.typicode.com/users";

class Api {
  List users = [];

  Future<List> fecthUserList() async {
    http.Response response = await http.get(Uri.encodeFull(_apiEndpoint),
        headers: {"Accept": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('error getting users');
    }

    List decodedJson = json.decode(response.body);

    decodedJson.forEach((res) => {users.add(UserModel.fromJSON(res).name)});

    // UserModel.fromJSON(decodedJson);

    // print(UserModel.fromJSON(decodedJson));
    return users;
  }
}
