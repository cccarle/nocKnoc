import 'package:flutter/material.dart';

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
      // INSERT CODE BELOW TO ADD ENG & SWE FLAGS
    );
  }
}

/* 
Code for implementing SWE & ENG flags
 */

// actions: <Widget>[
//   GestureDetector(
//     onTap: () => {},
//     child: Padding(
//       padding: EdgeInsets.only(right: 10.0, top: 10.0),
//       child: Image.asset(
//         'assets/images/sweFlag.png',
//         fit: BoxFit.contain,
//       ),
//     ),
//   ),
//   GestureDetector(
//       onTap: () => {},
//       child: Padding(
//         padding: EdgeInsets.only(right: 10.0, top: 10.0),
//         child: Image.asset(
//           'assets/images/engFlag.png',
//           fit: BoxFit.contain,
//         ),
//       )),
// ],
