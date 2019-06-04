import 'package:flutter/material.dart';
import '../../API/api.dart';
import '../../env/config.dart';
import '../../model/post_model.dart';
import 'dart:async';
import './dialog.dart';
import '../../config/globals.dart' as globals;

// Actions when not specified contcat is made
class AlternativeContact extends StatefulWidget {
  final String visitor;

  AlternativeContact(this.visitor);

  _AlternativeContactState createState() => _AlternativeContactState();
}

class _AlternativeContactState extends State<AlternativeContact> {
  Timer timer;
  static final threeSec = 3000;
  int _start = threeSec;

  _handleEvent(BuildContext context) {
    startTimer(context);
  }

  void handleCancelDialog(time, BuildContext context, Timer timer) {
    var apiKey = ConfigWrapper.of(context).apiKey;

    if (time == threeSec) {
      dialog
          .getCancelDialog(context, makeRequest, timer, setTimer, apiKey)
          .then(
            (onValue) {},
          );
    } else if (time == 300) {
      makeRequest(apiKey);
      Navigator.of(context).pop(true);
    }
  }

  void setTimer(value) {
    if (mounted) {
      setState(
        () {
          _start = value;
        },
      );
    }
  }

  void makeRequest(apiKey) {
    Post newPost = new Post(visitor: widget.visitor);
    createPost(body: newPost.toMap(), key: apiKey);
  }

  void startTimer(BuildContext context) {
    const oneSec = const Duration(milliseconds: 100);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => mounted ? setState(
            () {
              if (_start < 100) {
                dialog.alternativeDialog(context, false).then((onValue) {});
                timer.cancel();
              } else {
                handleCancelDialog(_start, context, timer);
                _start = _start - 100;
              }
            },
          ) : null
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_handleEvent(context)},
      onDoubleTap: () => {print},
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, top: 10.0),
          child: Container(
            height: 40.0,
            child: Text(
              globals.unknown,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize: 25.0),
            ),
          ),
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
