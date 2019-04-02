import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget _createGridList() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.only(top: 0.0),
      childAspectRatio: 12.0 / 9.0,
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('klick');
              },
              child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.blue,
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
                                'Besökare',
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
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('klick');
              },
              child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.blue,
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
                                'Besökare',
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
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('klick');
              },
              child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.blue,
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
                                'Besökare',
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
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('klick');
              },
              child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.blue,
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
                                'Besökare',
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
                        'assets/images/Logo.png',
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
                'assets/images/sweFlag.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0, top: 10.0),
              child: Image.asset(
                'assets/images/engFlag.png',
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
      body: Column(children: <Widget>[
        Text('Välkommer'),
        Text('Vem är du?'),
        Expanded(
          child: _createGridList(),
        )
      ]),
    );
  }
}
