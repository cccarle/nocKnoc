import 'package:flutter/material.dart';

class AlertIcon extends StatelessWidget {

  final String user;

  AlertIcon(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () => {print('Notifi $user')},
            child: Icon(Icons.notifications_active, size: 30.0),
          ),
        ],
      ),
    );
  }
}
