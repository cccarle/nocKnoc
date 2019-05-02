import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';
import '../API/api.dart';

class ListViewSlackUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Material(
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
    return filter == null || filter == ""
        ? slackUserListItem(index, list)
        : list[index].toLowerCase().contains(filter.toLowerCase())
            ? slackUserListItem(index, list)
            : Container();
  }
}

slackUserImage() {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black),
        // ),
        child: Image.network(
          'https://randomuser.me/api/portraits/med/men/65.jpg',
          fit: BoxFit.fill,
          height: 70.0,
          width: 70.0,
        ),
      ),
    ),
  );
}

alertIcon() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[Icon(Icons.notifications_active, size: 30.0)],
    ),
  );
}

middleSection(index, list) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            list[index],
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w200,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    ),
  );
}

slackUserListItem(index, list) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Row(
        children: <Widget>[
          slackUserImage(),
          middleSection(index, list),
          alertIcon()
        ],
      )
    ],
  );
}
