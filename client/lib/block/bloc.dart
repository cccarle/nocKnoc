import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';

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

/* 
Close streams
 */

  dispose() {
    _searchedUser.close();
  }
}
