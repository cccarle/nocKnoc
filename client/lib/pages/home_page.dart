import 'package:flutter/material.dart';
import './search_page.dart';
import '../widgets/appbar/app_bar.dart';
import '../env/config.dart';

import '../config/globals.dart' as globals;

class HomePage extends StatelessWidget {
  final String visitorOption1 = globals.visitorOption1;
  final String visitorOption2 = globals.visitorOption2;
  final String visitorOption3 = globals.visitorOption3;
  final String visitorOption4 = globals.visitorOption4;

  Widget build(BuildContext context) {
    var apiKey = ConfigWrapper.of(context).apiKey;

    final List<String> visitors = [
      visitorOption1,
      visitorOption2,
      visitorOption3,
      visitorOption4
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: DynamicAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headLineText(),
          _buildOptionsList(context, visitors, apiKey)
        ],
      ),
    );
  }

  Widget _headLineText() {
    return Column(
      children: <Widget>[
        Container(
          height: 125.0,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 35.0),
            child: Text(
              globals.welcomeText,
              style: TextStyle(fontSize: 90.0, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 40.0, top: 25.0),
          child: Text(
            globals.whoAreYou,
            style: TextStyle(fontSize: 70.0, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildOptionsList(context, visitors, apiKey) {
    return Expanded(
      child: GridView.count(
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 12.0 / 9.0,
        children: List.generate(
          visitors.length,
          (index) {
            return _buildOptionItem(context, index, visitors, apiKey);
          },
        ),
      ),
    );
  }
}

Widget _buildOptionItem(context, index, visitors, apiKey) {
  return Padding(
    padding: EdgeInsets.all(25.0),
    child: GestureDetector(
      onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (BuildContext context) =>
                    SearchPage(visitor: visitors[index], apiKey: apiKey),
              ),
            ),
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            visitors[index],
            style: TextStyle(fontSize: 40.0, fontFamily: 'Avenir'),
          ),
        ),
      ),
    ),
  );
}
