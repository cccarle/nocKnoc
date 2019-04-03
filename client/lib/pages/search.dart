import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 600.0,
            child: Container(
              child: ListView(children: <Widget>[
                Center(
                  child: Text(
                    'Vem söker du ?',
                    style: TextStyle(fontSize: 80.0, color: Colors.white),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {},
                ),
              ]),
            ),
          ),
        ));
  }
}
