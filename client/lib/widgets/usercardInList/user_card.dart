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

// Class that creates a interactive usercard
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
  bool _willContact = false;

  void _handleEvent(BuildContext context) {
    startTimer(context);
  }

  // Creates a dialog that is disposable if timer hits 300ms a request will be sent
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

  // Build an object and a post
  void makeRequest(apiKey) {
    Post newPost = new Post(
        name: widget.user.name,
        visitor: widget.visitor,
        channelId: widget.user.channels,
        userId: widget.user.userId);

    createPost(body: newPost.toMap(), key: apiKey);
  }

  // Creates a timer and creates a contact dialog
  void startTimer(BuildContext context) {
    const miliSecDuration = const Duration(milliseconds: 100);
    const int miliSecCount = 100;
    timer = new Timer.periodic(
      miliSecDuration,
      (Timer timer) => setState(
            () {
              if (_start < miliSecCount) {
                dialog.getDialog(context, widget.user, true).then((onValue) {});
                timer.cancel();
              } else {
                handleCancelDialog(_start, context, timer);
                _start = _start - miliSecCount;
              }
            },
          ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => _handleEvent(widget.context),
        onDoubleTap: () => {print},
        child: Container(
          child: Row(
            children: <Widget>[
              SlackUserImage(widget.user.image),
              SlackUsername(widget.user.name),
              AlertIcon(size: 30.0, color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }

  // Cancel the timer when class is disposed
  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
