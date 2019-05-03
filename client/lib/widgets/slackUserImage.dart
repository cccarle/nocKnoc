import 'package:flutter/material.dart';

class SlackUserImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          child: Image.network(
            'https://randomuser.me/api/portraits/med/men/65.jpg',
            fit: BoxFit.fill,
            height: 70.0,
            width: 70.0,
          ),
        ),
      ),
    );
  }
}


