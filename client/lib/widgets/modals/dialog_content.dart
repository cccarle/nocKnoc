import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'dart:async';

import './contact_response.dart';
import './dialog_text.dart';
import '../../model/user_model.dart';

class DialogContent extends StatefulWidget {
  final UserModel user;
  final bool isKnownContact;
  SocketIO socket;

  DialogContent({this.user, this.isKnownContact, this.socket});

  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  SocketIO _socket;
  String _message;
  bool _setView = true;
  @override
  void initState() {
    super.initState();
    this.setState(() => {_socket = widget.socket});
    _socket.connect();
    _startTimerToFallback();
  }

  void _startTimerToFallback() {
    Future.delayed(
      const Duration(seconds: 10),
      () {
        setState(
          () => {_message = "Ring växel 0724340454", _setView = false},
        );
      },
    );
  }

  Widget _buildDialogContent() {
    Widget dialog;
    if (widget.isKnownContact) {
      dialog = Container(
        child: Column(
          children: <Widget>[
            Center(
                child: ContactResponse(
                    context: context,
                    socket: _socket,
                    image: widget.user.image,
                    username: widget.user.name)),
            DialogText(
                socket: widget.socket,
                username: widget.user.name,
                context: context),
            SizedBox(height: 10.0),
          ],
        ),
      );
    } else {
      dialog = Container(
        child: Column(
          children: <Widget>[
            Center(
              child: ContactResponse(
                context: context,
                socket: _socket,
              ),
            ),
            SizedBox(height: 10.0),
            DialogText(socket: _socket, context: context),
          ],
        ),
      );
    }

    return dialog;
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialogContent();
  }
}
