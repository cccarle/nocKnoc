// import 'package:flutter/material.dart';

// class SearchBar extends StatefulWidget {
//   final items;
//   final String filter;

//   SearchBar(this.items, this.filter);

//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     print(widget.filter);
//     return ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: widget.items.length,
//         itemBuilder: (BuildContext context, int index) {
//           return widget.filter == null || widget.filter == ""
//               ? Card(
//                   child: Text(widget.items[index],
//                       style: TextStyle(fontSize: 40.0)))
//               : widget.items[index]
//                       .toLowerCase()
//                       .contains(widget.filter.toLowerCase())
//                   ? Card(
//                       child: Text(
//                       widget.items[index],
//                       style: TextStyle(fontSize: 40.0),
//                     ))
//                   : Container();
//         });
//   }
// }
