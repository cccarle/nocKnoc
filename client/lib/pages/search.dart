import 'package:flutter/material.dart';
import '../widgets/searchableList.dart';
import '../widgets/listView.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 600.0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Vem söker du ?',
                      style: TextStyle(fontSize: 80.0, color: Colors.white),
                    ),
                  ),
                  SearchableList(),
                  ListViewSlackUsers()
                ],
              ),
            ),
          ),
        ));
  }
}
