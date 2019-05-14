import 'dart:async';
// import '../model/user_model.dart';

class HelperFunctions {
  final validateSearchedUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (searchedLetter, sink) {
      sink.add(searchedLetter);
    },
  );

  final validateFlippedCard = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (open, sink) {
      sink.add(open);
    },
  );

  // final validateUserList =
  //     StreamTransformer<List, List<UserModel>>.fromHandlers(handleData: (list, sink) {
  //   sink.add(list);
  // });
}
