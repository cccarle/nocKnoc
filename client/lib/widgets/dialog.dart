import 'package:flutter/material.dart';
import 'dart:async';
import '../model/user_model.dart';

class Dialog {

  get getDialog => _showDialog;

  Future<bool> _showDialog(BuildContext context, UserModel user) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert Dialog title ${user.name}"),
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
      },
    );
  }
}

Dialog dialog = new Dialog();