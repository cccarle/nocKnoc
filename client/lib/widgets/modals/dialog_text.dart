import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

import '../../config/globals.dart' as globals;

class DialogText extends StatefulWidget {
  final BuildContext context;
  final String username;
  final SocketIO socket;

  DialogText(
      {this.context, this.username = globals.defaultMessage, this.socket});

  @override
  _DialogTextState createState() => _DialogTextState();
}

class _DialogTextState extends State<DialogText> {
  String _message;

  @override
  void initState() {
    super.initState();
    _setMessage();
    _listenOnSocket();
  }

  void _listenOnSocket() {
    widget.socket.on(
      'answer2',
      (responseFromSocket) {
        this.setState(() => {_message = responseFromSocket['text']});
        goBackToHomeScreen();
      },
    );
  }

  void goBackToHomeScreen() {
    Future.delayed(
      const Duration(seconds: 15),
      () {
        Navigator.of(widget.context).popUntil((route) => route.isFirst);
      },
    );
  }

  void _setMessage() {
    _message = globals.buildMessage("${widget.username}");
  }

  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _message,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
