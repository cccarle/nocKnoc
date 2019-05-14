import 'package:flutter/material.dart';
// import 'dart:async';
// import '../model/user_model.dart';

// import '../bloc/provider.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:io';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class DialogContent extends StatefulWidget {
  final SocketIO socket;

  DialogContent(this.socket);

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  String _name;

  @override
  void initState() {
    super.initState();
    widget.socket.connect();

    widget.socket.onConnect((data) {
      print("connected...");
      print(data);
    });

    widget.socket.on('answer', (data) {
      print(data);
      print('du är inne');
      this.setState(() => {_name = data});
    });
  }

  Widget build(BuildContext context) {
    return Text("Alert Dialog title asd $_name");
  }
}
