import 'package:flutter/material.dart';

//Widgets
import './alertIcon.dart';
import './slackUserImage.dart';
import './slackUsername.dart';

class UserCard extends StatelessWidget {
  final String user;

  UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => {print('Notifi $user')},
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
