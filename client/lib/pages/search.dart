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
  final List<String> test = ['Carl', 'Marcus', 'David', 'Joel', 'Karl'];
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 600.0,
            child: Container(
              child: Column(children: <Widget>[
                Center(
                  child: Text(
                    'Vem söker du ?',
                    style: TextStyle(fontSize: 80.0, color: Colors.white),
                  ),
                ),
                SearchableList(test)
              ]),
            ),
          ),
        ));
  }
}
