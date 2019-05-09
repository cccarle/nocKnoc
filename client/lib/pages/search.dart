import 'package:flutter/material.dart';
import '../widgets/searchInputField.dart';
import '../widgets/listView.dart';
import '../widgets/appBar.dart';
import '../widgets/flipCard.dart';
import '../bloc/provider.dart';

class SearchPage extends StatelessWidget {
  final String visitor;

  SearchPage(this.visitor);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
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
                _listViewSlackUsers(context, bloc),
              ],
            ),
          ),
        ));
  }

  // Widget _flippedView(context, bloc) {
  //   return StreamBuilder(
  //       stream: bloc.showFlippedCardStream,
  //       initialData: false,
  //       builder: (BuildContext context, snapshot) {
  //         return Container(
  //           height: 600.0,
  //           width: MediaQuery.of(context).size.width,
  //           child: FlipCard(
  //             isFront: snapshot.data,
  //             direction: FlipDirection.HORIZONTAL, // default
  //             front: _listViewSlackUsers(),
  //             back: Container(
  //               height: 500.0,
  //               color: Colors.white,
  //               child: Text('hej'),
  //             ),
  //           ),
  //         );
  //       });
  // }

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

  Widget _listViewSlackUsers(context, bloc) {
    return StreamBuilder(
      stream: bloc.showFlippedCardStream,
      initialData: false,
      builder: (BuildContext context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black,
                  offset: new Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  spreadRadius: 5.0)
            ],
          ),
          child: Container(
            height: 300,
            color: Colors.white,
            child: FlipCard(
              isFront: snapshot.data,
              direction: FlipDirection.HORIZONTAL, // default
              front: ListViewSlackUsers(visitor),
              back: Container(
                height: 500.0,
                color: Colors.white,
                child: Text('hej'),
              ),
            ),
          ),
        );
      },
    );
  }
}
