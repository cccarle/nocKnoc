import 'package:flutter/material.dart';
import './pages/home.dart';
import './bloc/provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method
import 'dart:io' show Platform;
import 'package:dotenv/dotenv.dart';

void main() async {
  runApp(Main());

  String envVars = Platform.environment['secret'];
  print(envVars);
  var bytes = utf8.encode("foobar"); // data being hashed

  var digest = sha1.convert(bytes);

  print("Digest as bytes: ${digest.bytes}");
  print("Digest as hex string: $digest");
}

class Main extends StatelessWidget {
  final meridiumBlue = const Color(0xFF09384E);
  final meridiumRed = const Color(0xFFDC3E2A);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Avenir',
            brightness: Brightness.light,
            primaryColor: meridiumBlue,
            accentColor: meridiumRed),
        home: HomePage(),
      ),
    );
  }
}
