import 'package:flutter/material.dart';

class SlackUsername extends StatelessWidget {
  final dynamic list;
  final dynamic index;

  SlackUsername(this.index, this.list);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              list[index],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// slackUsername(index, list) {
//   return Expanded(
//     child: Container(
//       padding: EdgeInsets.only(left: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Text(
//             list[index],
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w200,
//               fontSize: 20.0,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
