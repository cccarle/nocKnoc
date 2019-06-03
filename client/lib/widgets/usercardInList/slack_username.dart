import 'package:flutter/material.dart';

// Creates a text with a username
class SlackUsername extends StatelessWidget {
  final String user;

  SlackUsername(this.user);
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
              user,
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
