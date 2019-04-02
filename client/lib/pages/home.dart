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
                child: Image.asset(
                  'assets/Logo.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(child: Text('hej')),
    );
  }
}
