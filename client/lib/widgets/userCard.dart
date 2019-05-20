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
  Timer _timer;
  int _start;
  UserCard(this.user, this.visitor, this.context);
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  void initState() {
    super.initState();
  }

  _handleEvent(BuildContext context, UserModel user) {
    startTimer(context);
  }

  void handleCancelDialog(time) {
    print(time);
    if (time == 3000) {
      dialog.getCancelDialog(context).then((onValue) {});
    } else if (time == 600) {
      Navigator.of(context).pop(true);
      // Post newPost = new Post(
      //     name: widget.user.name,
      //     visitor: widget.visitor,
      //     channelId: widget.user.channels);

      // createPost(body: newPost.toMap());
    }
  }

  void startTimer(BuildContext context) {
    widget._start = 3000;
    const oneSec = const Duration(milliseconds: 100);
    print(widget._start);
    widget._timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (widget._start < 500) {
                timer.cancel();
                dialog.getDialog(context, widget.user).then((onValue) {});


                // riktiga modal
                // http anrop
              } else {
                handleCancelDialog(widget._start);
                widget._start -= 100;
                // ladndingknappen
              }
            },
          ),
    );
  }

  @override
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

  void dispose() {
    widget._timer.cancel();
    super.dispose();
  }
}
