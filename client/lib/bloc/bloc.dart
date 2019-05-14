import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'helper_functions.dart';

// import '../model/user_model.dart';

class Bloc with HelperFunctions {
  final _searchedUser = BehaviorSubject<String>();
  final _showFlippedCard = BehaviorSubject<bool>();
  final _userFromSocket = BehaviorSubject<String>();
  // final _userList = BehaviorSubject<UserModel>();
/* 
  Add to stream
 */

  Stream<String> get searchedUserStream =>
      _searchedUser.stream.transform(validateSearchedUser);

  Stream<bool> get showFlippedCardStream =>
      _showFlippedCard.stream.transform(validateFlippedCard);

  Stream<String> get userFromSocketStream =>
      _userFromSocket.stream.transform(validateSocketUser);

  // Stream<UserModel> get showUserListStream => _userList.stream.transform(validateUserList)
/* 
  Change data
 */

  Function(String) get changeSearchBarInput => _searchedUser.sink.add;
  Function(bool) get changeFlippedState => _showFlippedCard.sink.add;
  Function(String) get getUserFromSocket => _userFromSocket.sink.add;

  changeBool() {
    bool asd = true;
    changeFlippedState(asd);
  }

/* 
Close streams
 */

  dispose() {
    _searchedUser.close();
    _showFlippedCard.close();
    _userFromSocket.close();
  }
}
