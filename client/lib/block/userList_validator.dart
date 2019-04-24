import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'dart:convert';

class UserListValidator {
  final validateUserList = StreamTransformer<List, String>.fromHandlers(
    handleData: (list, sink) {
      print(list);
    },
  );
}
