import 'package:flutter/material.dart';

import './pages/home.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  final meridiumBlue = const Color(0xFF09384E);
  final meridiumRed = const Color(0xFFDC3E2A);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //     brightness: Brightness.light,
      //     primarySwatch: meridiumBlue,
      //     accentColor: meridiumRed),
      home: HomePage(),
    );
  }
}
