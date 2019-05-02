import 'package:flutter/material.dart';
import './search.dart';

class HomePage extends StatelessWidget {
  List<String> options = ["Leverans", "Besökare", "Affärspatner", "Anställd"];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 125.0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 25.0),
                    child: Text(
                      'Välkommen!',
                      style: TextStyle(fontSize: 90.0, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Text(
                    'Vem är du?',
                    style: TextStyle(fontSize: 70.0, color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: _buildOptionsList(),
            )
          ]),
    );
  }

  Widget _buildOptionItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(options[index]),
                    ),
                  ),
                },
            child: Container(
                height: 280,
                width: 370,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              options[index],
                              style: TextStyle(
                                  fontSize: 40.0, fontFamily: 'Avenir'),
                            ),
                          ],
                        ),
                      )),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildOptionsList() {
    return ListView.builder(
        itemBuilder: _buildOptionItem, itemCount: options.length);
  }
}
