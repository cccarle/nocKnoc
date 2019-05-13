import 'package:flutter/material.dart';
import './pages/home.dart';
import './bloc/provider.dart';
// import './widgets/swipe_page.dart';

void main() {
  runApp(Main());
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
