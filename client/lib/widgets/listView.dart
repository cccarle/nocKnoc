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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            height: 600.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: createFutureList(bloc),
            ),
          ),
        ],
      ),
    ));
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
                  return buildList(asyncsnapshot.data, snapshot.data);
                }
            }
          },
        );
      },
    );
  }

  buildList(asyncsnapshot, snapshot) {
    return new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: asyncsnapshot.length,
        itemBuilder: (BuildContext context, int index) {
          return selectList(index, snapshot, asyncsnapshot);
        });
  }

  selectList(index, filter, list) {
    return filter == null || filter == ""
        ? Card(
            child: Stack(
              children: <Widget>[
                // Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/med/men/65.jpg'),
                  ),
                ),
                Align(
                  child: Column(
                      
                    children: <Widget>[
                      Text(
                        list[index],
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.notifications_active),
                )
                // ),
              ],
            ),
          )
        : list[index].toLowerCase().contains(filter.toLowerCase())
            ? Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/med/men/65.jpg')),
                        Text(
                          list[index],
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Rs.',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container();
  }
}

// Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       // Image.network(
//       //   'https://randomuser.me/api/portraits/med/men/65.jpg',
//       // ),
//       Text(
//         list[index],
//         style: TextStyle(fontSize: 20.0),
//       ),
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           image: backgroundImage != null
//               ? new DecorationImage(
//                   image: backgroundImage, fit: BoxFit.cover)
//               : null,
//           shape: BoxShape.circle,
//         ),
//       )
//     ],
//   )
