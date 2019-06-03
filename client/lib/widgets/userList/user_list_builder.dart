import 'package:flutter/material.dart';
import 'dart:async';
// Bloc
import '../../bloc/bloc.dart';
import '../../bloc/provider.dart';
// Model
import '../../model/user_model.dart';
// Pages
import '../../pages/error_page.dart';

// Widgets
import '../../widgets/usercardInList/user_card.dart';

// Class that build a list of users
class UserListBuilder extends StatelessWidget {
  final String visitor;
  final Future<List<UserModel>> list;
  final double number;
  final BuildContext context;

  UserListBuilder(this.visitor, this.list, this.number, this.context);

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
              height: number,
              child: _createFutureList(bloc),
            ),
          ],
        ),
      ),
    );
  }

  _createFutureList(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        return FutureBuilder<List<UserModel>>(
          future: list,
          builder: (BuildContext context,
              AsyncSnapshot<List<UserModel>> asyncsnapshot) {
            switch (asyncsnapshot.connectionState) {
              case ConnectionState.none:
                return Text('dasd');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('loading');
              case ConnectionState.done:
                if (asyncsnapshot.hasError) {
                  return ErrorPage();
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
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: asyncsnapshot.length,
      itemBuilder: (BuildContext context, int index) {
        return _selectList(index, snapshot, asyncsnapshot);
      },
    );
  }

  // makes list searchable
  _selectList(index, filter, userObject) {
    return filter == null || filter == ""
        ? _slackUserListItem(index, userObject[index])
        : userObject[index].name.toLowerCase().contains(filter.toLowerCase())
            ? _slackUserListItem(index, userObject[index])
            : Container();
  }

  // creates every item in the list
  _slackUserListItem(index, userObject) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        UserCard(userObject, visitor, context),
      ],
    );
  }
}
