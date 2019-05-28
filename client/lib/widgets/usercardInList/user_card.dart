import 'package:flutter/material.dart';
import 'dart:async';

//Model
import '../../model/post_model.dart';
import '../../env/config.dart';

//Statemanagement
import '../../model/user_model.dart';

//Widgets
import './alert_Icon.dart';
import './slack_user_image.dart';
import './slack_username.dart';
import '../../widgets/modals/dialog.dart';

//Api
import '../../API/api.dart';

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

  void _handleEvent(BuildContext context) {
    startTimer(context);
  }

  void handleCancelDialog(time, BuildContext context, Timer timer) {
    var apiKey = ConfigWrapper.of(context).apiKey;

    if (time == 3000) {
      dialog
          .getCancelDialog(context, makeRequest, timer, setTimer, apiKey)
          .then((onValue) {});
    } else if (time == 300) {
      makeRequest(apiKey);
      Navigator.of(context).pop(true);
    }
  }

  void setTimer(value) {
    setState(() {
      _start = value;
    });
  }

  void makeRequest(apiKey) {
    Post newPost = new Post(
        name: widget.user.name,
        visitor: widget.visitor,
        channelId: widget.user.channels,
        userId: widget.user.userId);

    createPost(body: newPost.toMap(), key: apiKey);
  }

  void startTimer(BuildContext context) {
    const oneSec = const Duration(milliseconds: 100);

    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 100) {
                dialog.getDialog(context, widget.user, true).then((onValue) {});
                timer.cancel();
              } else {
                handleCancelDialog(_start, context, timer);
                _start = _start - 100;
              }
            },
          ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _handleEvent(widget.context),
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

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}