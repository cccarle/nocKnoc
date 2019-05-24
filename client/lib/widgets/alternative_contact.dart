import 'package:flutter/material.dart';
import '../API/api.dart';
import '../env/config.dart';
import '../model/post_model.dart';

class AlternativeContact extends StatelessWidget {
  String visitor;

  AlternativeContact(this.visitor);
  @override
  Widget build(BuildContext context) {
    var apiKey = ConfigWrapper.of(context).apiKey;
    Post newPost = new Post(
      visitor: visitor,
    );
    return GestureDetector(
      onTap: () => createPost(body: newPost.toMap(), key: apiKey),
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
