import 'package:flutter/material.dart';
import '../widgets/searchableList.dart';
import '../widgets/listView.dart';
import '../widgets/appBar.dart';


class SearchPage extends StatelessWidget {
  String option;

  SearchPage(this.option);

  @override
  Widget build(BuildContext context) {
    print(option);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: DynamicAppBar(),
        ),
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
                  Container(
                    width: 400,
                    child: SearchableList(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 600,
                    color: Colors.transparent,
                    child: ListViewSlackUsers(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
