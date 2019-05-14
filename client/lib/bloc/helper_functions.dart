import 'dart:async';

import '../sockets/connectSocket.dart';

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

  final validateSocketUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (user, sink) {
//socket ON
      // startSocketConnection();

      sink.add(user);
    },
  );
}
