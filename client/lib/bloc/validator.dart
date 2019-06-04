import 'dart:async';

// Takes the string from the input field and adds it to a sink
class Validator {
  final insertSearchedWord =
      StreamTransformer<String, String>.fromHandlers(handleData: (word, sink) {
    sink.add(word);
  });
}
