import 'dart:async';

class Validator {
  final insertSearchedWord =
      StreamTransformer<String, String>.fromHandlers(handleData: (word, sink) {
    sink.add(word);
  });
}
