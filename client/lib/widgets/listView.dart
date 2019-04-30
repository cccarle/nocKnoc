import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';

class ListViewSlackUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final List<String> list = ["hes", "jkas"];
    return Material(
      child: Column(
        children: <Widget>[renderListView(bloc, list)],
      ),
    );
  }

  renderListView(Bloc bloc, list) {
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return selectList(index, snapshot.data, list);
            },
          );
        } else {
          return Container(
            child: Text('No searech field'),
          );
        }
      },
    );
  }

  selectList(index, filter, list) {
    print(list);
    return filter == null || filter == ""
        ? Card(
            child: Text(
              list[index],
              style: TextStyle(fontSize: 40.0),
            ),
          )
        : list[index].toLowerCase().contains(filter.toLowerCase())
            ? Card(
                child: Text(
                  list[index],
                  style: TextStyle(fontSize: 40.0),
                ),
              )
            : Container();
  }
}
