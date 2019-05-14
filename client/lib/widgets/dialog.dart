import 'package:flutter/material.dart';
import 'dart:async';
import '../model/user_model.dart';
import '../bloc/provider.dart';


class Dialog {
  get getDialog => _showDialog;

  Future<bool> _showDialog(BuildContext context, UserModel user) {
    final bloc = Provider.of(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
            stream: bloc.userFromSocketStream,
            builder: (context, snapshot) {
              return AlertDialog(
                title: new Text("Alert Dialog title ${snapshot.data}"),
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
