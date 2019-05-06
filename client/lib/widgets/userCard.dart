import 'package:flutter/material.dart';

//Widgets
import './alertIcon.dart';
import './slackUserImage.dart';
import './slackUsername.dart';

//Api
import '../API/api.dart';

//Model
import '../model/post_model.dart';

//Statemanagement
import '../bloc/bloc.dart';
import '../bloc/provider.dart';

class UserCard extends StatelessWidget {
  final String user;
  final String visitor;

  UserCard(this.user, this.visitor);

  _handleEvent(bloc) {
    print('eeje');
    Post newPost = new Post(user: user, visitor: visitor);
    createPost(body: newPost.toMap());
    // bloc.changeFlippedState(true);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    // Post newPost = new Post(user: user, visitor: visitor);
    return Container(
      child: GestureDetector(
        onTap: () => {print('hej')},
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
