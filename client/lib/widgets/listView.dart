import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';

// Widgets
import '../API/api.dart';

//Api
import '../widgets/userCard.dart';

import '../model/user_model.dart';

class ListViewSlackUsers extends StatelessWidget {
  final String visitor;

  ListViewSlackUsers(this.visitor);

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
              child: _createFutureList(bloc),
            ),
          ],
        ),
      ),
    );
  }

  _createFutureList(Bloc bloc) {
    final Future<List<UserModel>> list = fecthUserList();
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        return FutureBuilder<List<UserModel>>(
          future: list,
          builder: (BuildContext context,
              AsyncSnapshot<List<UserModel>> asyncsnapshot) {
            switch (asyncsnapshot.connectionState) {
              case ConnectionState.none:
                return Text('input a url');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('loadinf');
              case ConnectionState.done:
                if (asyncsnapshot.hasError) {
                  return Text(
                    '${asyncsnapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return _buildList(asyncsnapshot.data, snapshot.data);
                }
            }
          },
        );
      },
    );
  }

  _buildList(asyncsnapshot, snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: asyncsnapshot.length,
      itemBuilder: (BuildContext context, int index) {
        return _selectList(index, snapshot, asyncsnapshot);
      },
    );
  }

  _selectList(index, filter, userObject) {
    return filter == null
        ? _slackUserListItem(index, userObject[index])
        : userObject[index].name.toLowerCase().contains(filter.toLowerCase())
            ? _slackUserListItem(index, userObject[index])
            : Container();
  }

  _slackUserListItem(index, userObject) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        UserCard(userObject, visitor)
      ],
    );
  }
}
