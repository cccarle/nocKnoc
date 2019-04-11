import 'package:flutter/material.dart';
import '../block/bloc.dart';
import '../block/provider.dart';

class SearchableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Material(
      child: Column(
        children: <Widget>[renderTextInput(bloc)],
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

  // renderListView() {
  //   return Container(
  //     decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
  //     child: ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       itemCount: items.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         selectList(index);
  //       },
  //     ),
  //   );
  // }

  // selectList(index) {
  //   return filter == null || filter == ""
  //       ? Card(
  //           child: Text(
  //             widget.items[index],
  //             style: TextStyle(fontSize: 40.0),
  //           ),
  //         )
  //       : widget.items[index].toLowerCase().contains(filter.toLowerCase())
  //           ? Card(
  //               child: Text(
  //                 widget.items[index],
  //                 style: TextStyle(fontSize: 40.0),
  //               ),
  //             )
  //           : Container();
  // }
}
