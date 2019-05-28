import 'package:flutter/material.dart';
import '../widgets/appbar/app_bar.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Något gick fel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55.0,fontFamily: 'Avenir'),
              ),
            ),
            Center(
              child: Text(
                'Ring växel 0724340454',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,fontFamily: 'Avenir'),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('Reconnect', style: TextStyle(fontFamily: 'Avenir'),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
