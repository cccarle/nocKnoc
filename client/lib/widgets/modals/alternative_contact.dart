import 'package:flutter/material.dart';
import '../../API/api.dart';
import '../../env/config.dart';
import '../../model/post_model.dart';
import 'dart:async';
import './dialog.dart';

class AlternativeContact extends StatefulWidget {
  final String visitor;

  AlternativeContact(this.visitor);

  _AlternativeContactState createState() => _AlternativeContactState();
}

class _AlternativeContactState extends State<AlternativeContact> {
  Timer timer;
  int _start = 3000;

  _handleEvent(BuildContext context) {
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
    print(widget.visitor);
    Post newPost = new Post(visitor: widget.visitor);
    print(newPost.toMap());
    createPost(body: newPost.toMap(), key: apiKey);
  }

  void startTimer(BuildContext context) {
    const oneSec = const Duration(milliseconds: 100);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 100) {
                dialog.alternativeDialog(context, false).then((onValue) {});
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleEvent(context),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'Jag vet inte vem jag söker?',
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}
