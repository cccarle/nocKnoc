import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget _createGridList() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.only(top: 20.0),
      childAspectRatio: 12.0 / 9.0,
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('klick');
              },
              child: Container(
                  height: 320,
                  width: 420,
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
                  height: 320,
                  width: 420,
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
                                'Affärspartner',
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
                  height: 320,
                  width: 420,
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
                                'Anställd',
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
                  height: 320,
                  width: 420,
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
                                'Leverans',
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
      backgroundColor: Theme.of(context).primaryColor,
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
              child: _createGridList(),
            )
          ]),
    );
  }
}
