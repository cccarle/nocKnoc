import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  Widget _createGridList()  {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(10.0),
      childAspectRatio: 8.0 / 9.0,
      children: <Widget>[
        Column (children: <Widget>[
          Container(child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text('Besökare'),
              ],
            ),
          ),)
        ],),
        Column (children: <Widget>[
          Container(child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text('Anställd'),
              ],
            ),
          ),)
        ],),
        Column (children: <Widget>[
          Container(child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text('Affärspartner'),
              ],
            ),
          ),)
        ],),
        Column (children: <Widget>[
          Container(child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text('Leverans'),
              ],
            ),
          ),)
        ],)
      ],
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/Logo.png',
                        fit: BoxFit.contain,
                      ),
                    ],
                  ))
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0, top: 10.0),
              child: Image.asset(
                'assets/sweFlag.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0,top: 10.0),
              child: Image.asset(
                'assets/engFlag.png',
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
      body: Container(child: _createGridList()),
    );
  }
}
