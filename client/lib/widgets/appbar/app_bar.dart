import 'package:flutter/material.dart';

class DynamicAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget meridiumLogo() {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/Logo.png',
              fit: BoxFit.contain,
            ),
          ],
        ),
      );
    }

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [meridiumLogo()],
      ),
      actions: <Widget>[
        // insert Flags here
      ],
    );
  }

  // Widget swedishFlag() {
  //   return GestureDetector(
  //     onTap: () => {globals.isSwe = true},
  //     child: Padding(
  //       padding: EdgeInsets.only(right: 10.0, top: 10.0),
  //       child: Image.asset(
  //         'assets/images/sweFlag.png',
  //         fit: BoxFit.contain,
  //       ),
  //     ),
  //   );
  // }

  // Widget englishFlag() {
  //   return GestureDetector(
  //     onTap: () => {globals.isSwe = false},
  //     child: Padding(
  //       padding: EdgeInsets.only(right: 10.0, top: 10.0),
  //       child: Image.asset(
  //         'assets/images/engFlag.png',
  //         fit: BoxFit.contain,
  //       ),
  //     ),
  //   );
  // }

}
