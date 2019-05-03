import 'package:flutter/material.dart';

//Widgets
import './alertIcon.dart';
import './slackUserImage.dart';
import './slackUsername.dart';

//Api
import '../API/api.dart';

//Model
import '../model/post_model.dart';

class UserCard extends StatelessWidget {
  final String user;
  final String visitor;

  UserCard(this.user, this.visitor);

  @override
  Widget build(BuildContext context) {
    Post newPost = new Post(user: user, visitor: visitor);
    return Container(
      child: GestureDetector(
        onTap: () => {createPost(body: newPost.toMap())},
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
