import 'package:flutter/material.dart';
import '../API/api.dart';

class AlternativeContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => createPost(),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Jag vet inte vem jag söker?',
              style: TextStyle(
                  color: Colors.white, decoration: TextDecoration.underline),
            ),
          )),
    );
  }
}
