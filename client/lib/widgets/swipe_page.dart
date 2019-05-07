import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwipePageState();
}

class SwipePageState extends State<SwipePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('Show / Hide'),
              onPressed: () {
                switch (controller.status) {
                  case AnimationStatus.completed:
                    controller.reverse();
                    break;
                  case AnimationStatus.dismissed:
                    controller.forward();
                    break;
                  default:
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
                position: offset,
                child: Container(
                  width: 700,
                  color: Colors.red,
                  child: Text('asd'),
                )),
          )
        ],
      ),
    );
  }
}
