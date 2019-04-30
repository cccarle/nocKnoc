import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';
import '../API/api.dart';

class ListViewSlackUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Material(
        child: new SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[renderListView(bloc)],
      ),
    ));
  }

  renderListView(Bloc bloc) {
    final Future<List<String>> list = fecthUserList();
    print(list);
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        if (snapshot.data != null && list != null) {
          return FutureBuilder<List<String>>(
            future: list,
            builder: (BuildContext context,
                AsyncSnapshot<List<String>> asyncsnapshot) {
              switch (asyncsnapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('input a url');
                case ConnectionState.waiting:
                  return new Center(child: new CircularProgressIndicator());
                case ConnectionState.active:
                  return new Text('');
                case ConnectionState.done:
                  if (asyncsnapshot.hasError) {
                    return new Text(
                      '${asyncsnapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: asyncsnapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return selectList(
                              index, snapshot.data, asyncsnapshot.data);
                        });
                  }
              }
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
