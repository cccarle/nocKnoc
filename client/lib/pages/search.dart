import 'package:flutter/material.dart';
import '../widgets/list.dart';
import '../widgets/searchableList.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  List<String> test = ['hej', '35', '23'];
  @override
  Widget build(BuildContext context) {
  print(test);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          width: 600.0,
          child: Container(child: SearchableList(test)),
        ),
      ),
    );
  }
}
