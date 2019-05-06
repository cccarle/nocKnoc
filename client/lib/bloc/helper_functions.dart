import 'dart:async';

class HelperFunctions {
  final validateSearchedUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (searchedLetter, sink) {
      sink.add(searchedLetter);
    },
  );

  final validateFlippedCard = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (open, sink) {
      print(open);
      sink.add(open);
    },
  );
}
