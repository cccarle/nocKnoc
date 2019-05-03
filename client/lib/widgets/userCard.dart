import 'package:flutter/material.dart';

//Widgets
import './alertIcon.dart';
import './slackUserImage.dart';
import './slackUsername.dart';

//Api
import '../API/api.dart';

class UserCard extends StatelessWidget {
  final String user;

  UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => {},
        child: Row(
          children: <Widget>[
            SlackUserImage(),
            SlackUsername(user),
            AlertIcon(user)
          ],
        ),
      ),
    );
  }
}
