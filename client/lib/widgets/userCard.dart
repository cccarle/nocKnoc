import 'package:flutter/material.dart';

//Widgets
import './alertIcon.dart';
import './slackUserImage.dart';
import './slackUsername.dart';

//Api
import '../API/api.dart';

//Model
import '../model/post_model.dart';
import '../widgets/contact_modal.dart';

//Statemanagement
import '../model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final String visitor;

  UserCard(this.user, this.visitor);

  // _handleEvent(bloc) {
  //   // print('eeje');
  //   // Post newPost = new Post(user: user, visitor: visitor);
  //   // createPost(body: newPost.toMap());
  //   new ContactModal();

  // }

  @override
  Widget build(BuildContext context) {
    final String name = user.name;
    final String channelId = user.channels;
    Post newPost = new Post(name: name, visitor: visitor, channelId: channelId);

    return Center(
        child: Container(
      child: GestureDetector(
        onTap: () => createPost(body: newPost.toMap()),
        child: Row(
          children: <Widget>[
            SlackUserImage(user.image),
            SlackUsername(user.name),
            AlertIcon()
          ],
        ),
      ),
    ));
  }
}

// import 'package:flutter/material.dart';

// //Widgets
// import './alertIcon.dart';
// import './slackUserImage.dart';
// import './slackUsername.dart';

// //Api
// import '../API/api.dart';

// //Model
// import '../model/post_model.dart';
// import '../widgets/contact_modal.dart';

// //Statemanagement
// import '../model/user_model.dart';

// class UserCard extends StatelessWidget {
//   final UserModel user;
//   final String visitor;

//   UserCard(this.user, this.visitor);

//   // _handleEvent(bloc) {
//   //   // print('eeje');
//   //   // Post newPost = new Post(user: user, visitor: visitor);
//   //   // createPost(body: newPost.toMap());
//   //   new ContactModal();

//   // }

// @override
// Widget build(BuildContext context) {
//   // Post newPost = new Post(user: user, visitor: visitor);
//   return Container(
//     child: GestureDetector(
//       onTap: () =>
//           Navigator.of(context).push<Widget>(PageRouteBuilder<Widget>(
//               opaque: true,
//               transitionDuration: Duration(days: 1),
//               pageBuilder: (BuildContext context, _, __) {
//                 return Container(
//                   height: 500.0,
//                   child: AlertDialog(
//                     title: Text('Are you sure'),
//                     content: Text('This action cannot be undone'),
//                     actions: <Widget>[
//                       FlatButton(
//                         child: Text('DISCARD'),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                   color: Colors.black.withOpacity(0.90),
//                 );
//               })),
//         child: Row(
//           children: <Widget>[
//             SlackUserImage(user.image),
//             SlackUsername(user.name),
//             AlertIcon()
//           ],
//         ),
//       ),
//     );
//   }
// // }
// {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute<bool>(
//                   builder: (BuildContext context) => Container(
//                         child: Center(
//                           child: AlertDialog(
//                             title: Text('Vi kontaktar ' + name),
//                             actions: <Widget>[
//                               Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     CircularProgressIndicator(),
//                                     FlatButton(
//                                       child: Text('Avbryt'),
//                                       onPressed: () {
//                                         Navigator.pop(context, true);
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         color: Colors.black.withOpacity(0.90),
//                       ),
//                 ),
//               ),
//             },
