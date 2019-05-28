import 'package:flutter/material.dart';

class SlackUserImage extends StatelessWidget {
  final String image;
  SlackUserImage(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          child: Image.network(
            image,
            fit: BoxFit.fill,
            height: 70.0,
            width: 70.0,
          ),
        ),
      ),
    );
  }
}
