import 'package:flutter/material.dart';

class AlertIcon extends StatelessWidget {
  final double size;
  final Color color;
  AlertIcon({this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.notifications_active, size: size, color: color),
    );
  }
}
