import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';


class ListViewSlackUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Material(
      child: Column(
        children: <Widget>[renderListView(bloc)],
      ),
    );
  }

  renderListView(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Container(
            child: Text(snapshot.data),
          );
        } else {
          return Container(
            child: Text('No searech field'),
          );
        }
      },
    );
  }

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
