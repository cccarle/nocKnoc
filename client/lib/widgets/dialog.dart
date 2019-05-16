// import 'package:flutter/material.dart';
// // import '../model/user_model.dart';

// import 'dart:async';
// // import '../bloc/provider.dart';
// // import 'package:flutter/foundation.dart';
// // import 'dart:io';
// // import '../sockets/connectSocket.dart';
// // import './adhara_socket_io.dart';

// import '../widgets/dialog_content.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

// class Dialog {
//   get getDialog => _showDialog;

//   Future<Widget> _showDialog(BuildContext context) {
//     return DialogContent(context);
//   }
// }

// Dialog dialog = new Dialog();

import 'package:flutter/material.dart';
import 'dart:async';
import '../model/user_model.dart';
import '../bloc/provider.dart';

import '../widgets/dialog_content.dart';

class Dialog {
  get getDialog => _showDialog;

  Future<bool> _showDialog(BuildContext context, UserModel user) async {
    final bloc = Provider.of(context);
    SocketIOManager manager = SocketIOManager();
    final SocketIO socket =
        await manager.createInstance('https://3298db41.ngrok.io');

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
            stream: bloc.userFromSocketStream,
            builder: (context, snapshot) {
              return AlertDialog(
                title: DialogContent(socket),
                content: new Text("Alert Dialog body"), 
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}

Dialog dialog = new Dialog();
