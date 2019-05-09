import 'package:flutter/material.dart';

class AlertIcon extends StatelessWidget {
  final String user;

  AlertIcon(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.notifications_active, size: 30.0),
    );
  }
}
