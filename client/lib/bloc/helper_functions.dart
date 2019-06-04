import 'dart:async';

class HelperFunctions {
  final validateSearchedUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (searchedLetter, sink) {
      sink.add(searchedLetter);
    },
  );
}
