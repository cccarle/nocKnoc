import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'dart:async';

// Widgets
import './contact_response.dart';
import './dialog_text.dart';
import '../../model/user_model.dart';

// Config
import '../../config/globals.dart' as globals;

class DialogContent extends StatefulWidget {
  final UserModel user;
  final bool isKnownContact;
  final SocketIO socket;

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

    this.setState(
      () => {_socket = widget.socket},
    );

    _startTimerToReceptionNumber();
    _startSocketConnection();
    _goBackToHomeScreen();
  }

  Widget buildModalForUserList() {
    return _setView
        ? Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: ContactResponse(
                      context: context,
                      socket: _socket,
                      image: widget.user.image,
                      username: widget.user.name),
                ),
                SizedBox(height: 25.0),
                DialogText(
                    socket: widget.socket,
                    username: widget.user.name,
                    context: context),
              ],
            ),
          )
        : Container(
            child: Center(
              child: Text(
                globals.lastMessage,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ),
          );
  }

  Widget buildModalForUnknowUser() {
    return _setView
        ? Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: ContactResponse(
                    context: context,
                    socket: _socket,
                  ),
                ),
                SizedBox(height: 25.0),
                Center(child: DialogText(socket: _socket, context: context)),
              ],
            ),
          )
        : Container(
            child: Center(
              child: Text(
                globals.lastMessage,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ),
          );
  }

  Widget _buildDialogContent() {
    Widget modal;

    if (widget.isKnownContact) {
      modal = buildModalForUserList();
    } else {
      modal = buildModalForUnknowUser();
    }
    return modal;
  }

  void _startTimerToReceptionNumber() {
    Future.delayed(
      const Duration(seconds: 50),
      () {
        setState(
          () => {
                _message = globals.lastMessage,
                _setView = globals.showSuportView
              },
        );
      },
    );
  }

  void _goBackToHomeScreen() {
    Future.delayed(
      const Duration(seconds: 90),
      () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  void _startSocketConnection() {
    _socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialogContent();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
