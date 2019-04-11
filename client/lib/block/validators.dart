import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'dart:convert';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      print(email);
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('Enter valid email');
      }
    },
  );
}
