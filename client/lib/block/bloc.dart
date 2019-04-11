import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

class Bloc with Validators {
  final _searchedUser = BehaviorSubject<String>();
/* 
  Add to stream
 */

  Stream<String> get email => _searchedUser.stream.transform(validateEmail);
/* 
  Change data
 */

  listenForChanges() {}

  Function(String) get changeEmail => _searchedUser.sink.add;

/* 
Sign in user
 */

  submit() async {
    final userResult = _searchedUser.value;
    print(userResult);
  }

  fetchData() async {
    List user = [];
    var s;
    var response = await get('https://jsonplaceholder.typicode.com/users');
    var test = json.decode(response.body);
    test.forEach((res) => {s = UserModel.fromJSON(res), user.add(s)});
    user.forEach((res) => {print(res)});
  }

/* 
Close streams
 */

  dispose() {
    _searchedUser.close();
  }
}
