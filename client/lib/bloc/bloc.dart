import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'helper_functions.dart';

class Bloc with HelperFunctions {
  final _searchedUser = PublishSubject<String>();

/* 
  Add to stream
 */

  Stream<String> get searchedUserStream =>
      _searchedUser.stream.transform(validateSearchedUser);

  /* 
  Change data
 */

  Function(String) get changeSearchBarInput => _searchedUser.sink.add;

/* 
Close streams
 */

  dispose() {
    _searchedUser.close();
    print('asd');
  }
}
