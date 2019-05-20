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

import 'dart:async';

class UserCard extends StatefulWidget {
  final UserModel user;
  final String visitor;
  final BuildContext context;
  Timer timer;

  UserCard(this.user, this.visitor, this.context, this.timer);
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  int _start = 3000;


  _handleEvent(BuildContext context, UserModel user) {
    startTimer(context);
  }

  void handleCancelDialog(time, BuildContext context) {
    print(time);
    if (time == 3000) {
      dialog.getCancelDialog(context).then((onValue) {});
    } else if (time == 300) {
      Navigator.of(context).pop(true);
      Post newPost = new Post(
          name: widget.user.name,
          visitor: widget.visitor,
          channelId: widget.user.channels);

      createPost(body: newPost.toMap());
    }
  }

  void startTimer(BuildContext context) {
    const oneSec = const Duration(milliseconds: 100);
    widget.timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 100) {
                dialog.getDialog(context, widget.user).then((onValue) {});
                timer.cancel();
              } else {
                handleCancelDialog(_start, context);
                _start = _start - 100;
              }
            },
          ),
    );
  }

  @override
  void dispose() {
    widget.timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _handleEvent(widget.context, widget.user),
        child: Row(
          children: <Widget>[
            SlackUserImage(widget.user.image),
            SlackUsername(widget.user.name),
            AlertIcon()
          ],
        ),
      ),
    );
  }
}
