import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;

class DynamicAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Language language = new Language();
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/Logo.png',
                    fit: BoxFit.contain,
                  ),
                ],
              ))
        ],
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () => {globals.isSwe = true},
          child: Padding(
            padding: EdgeInsets.only(right: 10.0, top: 10.0),
            child: Image.asset(
              'assets/images/sweFlag.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        GestureDetector(
            onTap: () => {globals.isSwe = false},
            child: Padding(
              padding: EdgeInsets.only(right: 10.0, top: 10.0),
              child: Image.asset(
                'assets/images/engFlag.png',
                fit: BoxFit.contain,
              ),
            )),
      ],
    );
  }
}
