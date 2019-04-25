import 'package:flutter/material.dart';
import '../block/bloc.dart';
import '../block/provider.dart';
import '../API/api.dart';
import 'dart:async';

class SearchableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final api = new Api();

    final bloc = Provider.of(context);
    final list = api.fecthUserList();

    list.then((value) {
      print(value);
      return List();
    });

    return Material(
      child: Column(
        children: <Widget>[
          renderTextInput(bloc), /*renderListView(context) */
          renderListView(list)
        ],
      ),
    );
  }

  Widget renderTextInput(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.none,
                  ),
                ),
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white),
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  // renderTextInput() {
  //   return
  // }

  renderListView(list) {

    print(list);
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          selectList(index);
        },
      ),
    );
  }

  // test(index) {
  //   return Card(
  //     child: Text(

  //             widget.items[index],
  //             style: TextStyle(fontSize: 40.0),
  //     )
  //   )
  // }

  selectList(index) {
    return filter == null || filter == ""
        ? Card(
            child: Text(
              widget.items[index],
              style: TextStyle(fontSize: 40.0),
            ),
          )
        : widget.items[index].toLowerCase().contains(filter.toLowerCase())
            ? Card(
                child: Text(
                  widget.items[index],
                  style: TextStyle(fontSize: 40.0),
                ),
              )
            : Container();
  }
}
