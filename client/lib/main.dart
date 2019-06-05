import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './bloc/provider.dart';
import 'env/config.dart';
import './pages/error_page.dart';
import './config/globals.dart' as globals;
import './env/dev.dart';
import 'package:screen/screen.dart';
/* 
Starting point of the application.
To edit any global numbers such as:
 - URL-links
 - Strings in the UI  
 - Numbers for timers
 - UI colors
  please view: ./congif/globals
 */

void main() => runApp(
    new ConfigWrapper(config: Config.fromJson(config), child: new Main()));

class Main extends StatelessWidget {
  final meridiumBlue = const Color(globals.meridiumBlue);
  final meridiumRed = const Color(globals.meridiumRed);

  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);
    return Provider(
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Avenir',
            brightness: Brightness.light,
            primaryColor: meridiumBlue,
            accentColor: meridiumRed),
        home: HomePage(),
        routes: {
          '/error': (BuildContext context) => ErrorPage(),
        },
      ),
    );
  }
}
