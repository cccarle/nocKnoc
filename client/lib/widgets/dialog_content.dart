import 'package:flutter/material.dart';
// import 'dart:async';
// import '../model/user_model.dart';

// import '../bloc/provider.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:io';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class DialogContent extends StatefulWidget {
  final SocketIO socket;
  final String username;

  DialogContent(this.socket, this.username);

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  String _name;
  String _message;

  @override
  void initState() {
    super.initState();
    _setMessage();
    _listenOnSocket();
    widget.socket.connect();

    widget.socket.onConnect((data) {
      print("connected...");
    });
  }

  void _listenOnSocket() {
    widget.socket.on('answer', (data) {
      var _list = data.values.toList();
      this.setState(() => {_message = _list[3]});
    });
  }

  void _setMessage() {
    _message = "Vi kontaktar ${widget.username}";
  }

  Widget build(BuildContext context) {
    return Text(_message);
  }
}
