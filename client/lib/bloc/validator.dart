import 'dart:async';

class Validator {
  final insertSearchedWord =
    StreamTransformer<String, String>.fromHandlers(handleData: (word, sink) {
    sink.add(word);
  });

  final setUserData =
      StreamTransformer<List, List>.fromHandlers(handleData: (userData, sink) {
    if (userData != null) {
      sink.add(userData);
    } else {
      sink.addError('Data is null');
    }
  });

  final setUserDataLength =
      StreamTransformer<List, int>.fromHandlers(handleData: (userData, sink) {
    if (userData != null) {
      sink.add(userData.length);
    } else {
      sink.addError('Data is null');
    }
  });
}
