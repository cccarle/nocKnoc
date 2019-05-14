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
import 'package:adhara_socket_io/adhara_socket_io.dart';

import '../widgets/dialog_content.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final String visitor;

  UserCard(this.user, this.visitor);

  _handleEvent(BuildContext context, UserModel user) async {
    final String name = user.name;
    final String channelId = user.channels;
    Post newPost = new Post(name: name, visitor: visitor, channelId: channelId);

    createPost(body: newPost.toMap());
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance('https://3298db41.ngrok.io');

    
    dialog.getDialog(context, user).then((onValue) {
      print(onValue);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _handleEvent(context, user),
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
