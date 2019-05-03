import 'package:flutter/material.dart';
import '../widgets/searchInputField.dart';
import '../widgets/listView.dart';
import '../widgets/appBar.dart';

class SearchPage extends StatelessWidget {
  final String option;

  SearchPage(this.option);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: DynamicAppBar(),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 700.0,
            child: Column(
              children: <Widget>[
                _headlineText(),
                _searchInput(),
                SizedBox(height: 30),
                _listViewSlackUsers()
              ],
            ),
          ),
        ));
  }

  Widget _headlineText() {
    return Center(
      child: Text(
        'Vem söker du ?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 80.0, color: Colors.white),
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      width: 440,
      child: SearchInputField(),
    );
  }

  Widget _listViewSlackUsers() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListViewSlackUsers(),
    );
  }
}

        // boxShadow: [
        //   new BoxShadow(
        //       color: Colors.black,
        //       offset: new Offset(1.0, 1.0),
        //       blurRadius: 5.0,
        //       spreadRadius: 5.0)
        // ],