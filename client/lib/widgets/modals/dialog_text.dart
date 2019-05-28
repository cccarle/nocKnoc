import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class DialogText extends StatefulWidget {
  final BuildContext context;
  final String username;
  final SocketIO socket;

  DialogText({this.context, this.username = "någon på meridium", this.socket});

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
      (data) {
        this.setState(() => {_message = data['text']});
        goBackToHomeScreen();
      },
    );
  }

  void goBackToHomeScreen() {
    Future.delayed(
      const Duration(milliseconds: 6000),
      () {
        Navigator.of(widget.context).popUntil((route) => route.isFirst);
      },
    );
  }

  void _setMessage() {
    _message = "Vi kontaktar ${widget.username}";
  }

  Widget build(BuildContext context) {
    return Text(
      _message,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
