import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'helper_functions.dart';

class Bloc with HelperFunctions {
  final _searchedUser = BehaviorSubject<String>();
  final _showFlippedCard = BehaviorSubject<bool>();
/* 
  Add to stream
 */

  Stream<String> get searchedUserStream =>
      _searchedUser.stream.transform(validateSearchedUser);

  Stream<bool> get showFlippedCardStream =>
      _showFlippedCard.stream.transform(validateFlippedCard);
/* 
  Change data
 */

  Function(String) get changeSearchBarInput => _searchedUser.sink.add;
  Function(bool) get changeFlippedState => _showFlippedCard.sink.add;

  changeBool() {
    print('hello');
    bool asd = true;
    changeFlippedState(asd);
  }

/* 
Close streams
 */

  dispose() {
    _searchedUser.close();
    _showFlippedCard.close();
  }
}
