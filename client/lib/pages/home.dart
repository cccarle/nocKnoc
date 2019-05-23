import 'package:flutter/material.dart';
import './search.dart';
import '../widgets/appBar.dart';
import '../model/language_model.dart';
import '../env/config.dart';

class HomePage extends StatelessWidget {
  String a = "Leverans";
  String b = "Besökare";
  String c = "Affärspatner";
  String d = "Anställd";

  Widget build(BuildContext context) {
    var api = ConfigWrapper.of(context).apiKey;
    print(api);
    final List<String> visitors = [a, b, c, d];

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
          _buildOptionsList(context, visitors)
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
              'Välkommen!',
              style: TextStyle(fontSize: 90.0, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 40.0, top: 25.0),
          child: Text(
            'Vem är du?',
            style: TextStyle(fontSize: 70.0, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildOptionsList(context, visitors) {
    return Expanded(
      child: GridView.count(
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 12.0 / 9.0,
        children: List.generate(
          visitors.length,
          (index) {
            return _buildOptionItem(context, index, visitors);
          },
        ),
      ),
    );
  }
}

Widget _buildOptionItem(context, index, visitors) {
  return Padding(
    padding: EdgeInsets.all(25.0),
    child: GestureDetector(
      onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (BuildContext context) => SearchPage(visitors[index]),
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
