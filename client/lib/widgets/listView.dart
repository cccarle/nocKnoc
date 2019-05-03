import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';


// Widgets
import '../widgets/alertIcon.dart';
import '../widgets/slackUsername.dart';
import '../widgets/slackUserImage.dart';

import '../widgets/userCard.dart';

class ListViewSlackUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 600,
              child: createFutureList(bloc),
            ),
          ],
        ),
      ),
    );
  }

  createFutureList(Bloc bloc) {
    final Future<List<String>> list = fecthUserList();
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {

        return FutureBuilder<List<String>>(
          future: list,
          builder: (BuildContext context,
              AsyncSnapshot<List<String>> asyncsnapshot) {
            switch (asyncsnapshot.connectionState) {
              case ConnectionState.none:
                return Text('input a url');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('');
              case ConnectionState.done:
                if (asyncsnapshot.hasError) {
                  return Text(
                    '${asyncsnapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return buildList(asyncsnapshot.data, snapshot.data);
                }
            }
          },
        );
      },
    );
  }


  buildList(asyncsnapshot, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: asyncsnapshot.length,
        itemBuilder: (BuildContext context, int index) {
          return selectList(index, snapshot, asyncsnapshot);
        });
  }


  selectList(index, filter, list) {
    return filter == null
        ? slackUserListItem(index, list)
        : list[index].toLowerCase().contains(filter.toLowerCase())
            ? slackUserListItem(index, list)
            : Container();
  }
}

slackUserListItem(index, list) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      UserCard()
    ],
  );
}
