// import 'package:flutter/material.dart';
// import './pages/search.dart';
// import './widgets/appBar.dart';
// import './pages/home.dart';
// import './block/provider.dart';

// void main() {
//   runApp(Main());
// }

// class Main extends StatelessWidget {
//   final meridiumBlue = const Color(0xFF09384E);
//   final meridiumRed = const Color(0xFFDC3E2A);

//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       child: MaterialApp(
//         theme: ThemeData(
//             fontFamily: 'Avenir',
//             brightness: Brightness.light,
//             primaryColor: meridiumBlue,
//             accentColor: meridiumRed),
//         home: Scaffold(
//           appBar: PreferredSize(
//               preferredSize: Size.fromHeight(70.0), // here the desired height
//               child: DynamicAppBar()),
//           body: SearchPage(),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/users/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String userId;
  

  Post({this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['name'],
      
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.userId);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}