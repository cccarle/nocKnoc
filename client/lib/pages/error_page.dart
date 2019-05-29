import 'package:flutter/material.dart';
import '../widgets/appbar/app_bar.dart';
import '../config/globals.dart' as globals;

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 400.0,
          width: 500.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  globals.somethingWentWrong,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 55.0,
                      fontFamily: 'Avenir'),
                ),
              ),
              Center(
                child: Text(
                  globals.lastMessage,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      fontFamily: 'Avenir'),
                ),
              ),
              Center(
                child: RaisedButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: Text(
                   globals.tryAgain,
                    style: TextStyle(fontFamily: 'Avenir'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
