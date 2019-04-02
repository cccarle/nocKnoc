import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/Logo.png',
                        fit: BoxFit.contain,
                      ),
                    ],
                  ))
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0, top: 10.0),
              child: Image.asset(
                'assets/sweFlag.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0,top: 10.0),
              child: Image.asset(
                'assets/engFlag.png',
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
      body: Container(child: Text('hej')),
    );
  }
}
