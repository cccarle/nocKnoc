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

  UserCard(this.user, this.visitor, this.context);
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Timer timer;
  int _start = 3000;

  _handleEvent(BuildContext context, UserModel user) {
    startTimer(context);
  }

  void handleCancelDialog(time, BuildContext context, Timer timer) {
    if (time == 3000) {
      dialog
          .getCancelDialog(context, makeRequest, timer, setTimer)
          .then((onValue) {});
    } else if (time == 300) {
      makeRequest();
      Navigator.of(context).pop(true);
    }
  }

  void setTimer(value) {
    setState(() {
      _start = value;
    });
  }


  void makeRequest() {
    Post newPost = new Post(
        name: widget.user.name,
        visitor: widget.visitor,
        channelId: widget.user.channels);

    createPost(body: newPost.toMap());
  }

  void startTimer(BuildContext context) {
    const oneSec = const Duration(milliseconds: 100);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 100) {
                dialog.getDialog(context, widget.user).then((onValue) {});
                timer.cancel();
              } else {
                handleCancelDialog(_start, context, timer);
                _start = _start - 100;
              }
            },
          ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
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
            AlertIcon(size: 30.0, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
