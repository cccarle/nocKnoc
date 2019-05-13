import 'package:flutter/material.dart';

//Widgets
import './alertIcon.dart';
import './slackUserImage.dart';
import './slackUsername.dart';

//Api
import '../API/api.dart';

//Model
import '../model/post_model.dart';
// import '../widgets/contact_modal.dart';

//Statemanagement
import '../model/user_model.dart';
import '../widgets/dialog.dart';
import '../sockets/connectSocket.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final String visitor;

  UserCard(this.user, this.visitor);

  _handleEvent() {
    final String name = user.name;
    final String channelId = user.channels;
    Post newPost = new Post(name: name, visitor: visitor, channelId: channelId);

    createPost(body: newPost.toMap());

    // socket.listenOnSocket();
  }
  // dialog.getDialog(context, user).then((onValue) {
  //   // print(onValue);
  // })

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _handleEvent(),
        child: Row(
          children: <Widget>[
            SlackUserImage(user.image),
            SlackUsername(user.name),
            AlertIcon()
          ],
        ),
      ),
    );
  }
}
