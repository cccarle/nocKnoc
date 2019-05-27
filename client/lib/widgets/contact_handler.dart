import 'package:flutter/material.dart';
import '../widgets/dialog.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../API/api.dart';
import '../env/config.dart';
import 'dart:async';

class ContactHandler extends StatefulWidget {
  // BuildContext context;
  // UserModel user;
  // String visitor;
  // ContactHandler(this.context, this.user, this.visitor);

  _ContactHandlerState createState() => _ContactHandlerState();
}

class _ContactHandlerState extends State<ContactHandler> {
  Timer timer;
  int _start = 3000;

  void handleCancelDialog(time, BuildContext context, Timer timer) {
    var apiKey = ConfigWrapper.of(context).apiKey;

    if (time == 3000) {
      dialog
          .getCancelDialog(widget.context, makeRequest, timer, setTimer, apiKey)
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
        channelId: widget.user.channels);

    createPost(body: newPost.toMap(), key: apiKey);
  }

  void startTimer(BuildContext context) {
    const oneSec = const Duration(milliseconds: 100);
    print(_st)
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 100) {
              
                dialog
                    .getDialog(widget.context, widget.user)
                    .then((onValue) {});
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
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

}

//  ContactHandler contactHandler = new ContactHandler(widget.context );
