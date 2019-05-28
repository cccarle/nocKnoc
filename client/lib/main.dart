import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './bloc/provider.dart';
import 'env/config.dart';
import './pages/error_page.dart';
import './env/dev.dart';
import 'dart:io';

void main() => runApp(
    new ConfigWrapper(config: Config.fromJson(config), child: new Main()));

class Main extends StatelessWidget {
  final meridiumBlue = const Color(0xFF09384E);
  final meridiumRed = const Color(0xFFDC3E2A);

  checkInternet(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      }
    } on SocketException catch (_) {
        Navigator.pushReplacementNamed(context, '/error');
      print('not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternet(context);

    var config = ConfigWrapper.of(context).apiKey;
    print(config);
    return Provider(
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Avenir',
            brightness: Brightness.light,
            primaryColor: meridiumBlue,
            accentColor: meridiumRed),
        home: HomePage(),
        routes: {'/error': (BuildContext context) => ErrorPage()},
      ),
    );
  }
}
