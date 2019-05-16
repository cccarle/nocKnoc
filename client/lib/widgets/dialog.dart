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
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/dialog_content.dart';

class Dialog {
  get getDialog => _showDialog;

  Future<bool> _showDialog(BuildContext context, UserModel user) async {
    final bloc = Provider.of(context);
    SocketIOManager manager = SocketIOManager();
    final SocketIO socket =
        await manager.createInstance('https://f86e4075.ngrok.io');

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
            stream: bloc.userFromSocketStream,
            builder: (context, snapshot) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                )),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: new Container(
                  height: 400.0,
                  width: 600.0,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                        Center(
                        child: new Stack(
                          // fit: StackFit.loose,
                          children: <Widget>[
                            new Positioned(
                              // top: 5.0,
                              // left: MediaQuery.of(context).size.width * 0.50,
                              child: Center(
                                child:
                                    SpinKitRing(color: Colors.red, size: 78.0),
                              ),
                            ),
                            new Positioned(
                              // left: MediaQuery.of(context).size.width * 0.40,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Container(
                                    child: Image.network(
                                      user.image,
                                      fit: BoxFit.fill,
                                      height: 70.0,
                                      width: 70.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container()
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      DialogContent(socket, user.name),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

Dialog dialog = new Dialog();
