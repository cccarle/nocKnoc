import 'package:flutter/material.dart';
import './pages/home.dart';
import './bloc/provider.dart';
import 'package:crypto/crypto.dart';
import 'env/config.dart';

// void main() async {
//   runApp(Main());
// }
import './env/dev.dart';

void main() => runApp(
    new ConfigWrapper(config: Config.fromJson(config), child: new Main()));

class Main extends StatelessWidget {
  final meridiumBlue = const Color(0xFF09384E);
  final meridiumRed = const Color(0xFFDC3E2A);

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
