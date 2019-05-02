import 'package:flutter/material.dart';

class AlertIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[Icon(Icons.notifications_active, size: 30.0)],
      ),
    );
  }
}
