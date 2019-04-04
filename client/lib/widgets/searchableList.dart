import 'package:flutter/material.dart';

class SearchableList extends StatefulWidget {
  final List<String> items;
  SearchableList(this.items);

  @override
  _SearchableListState createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        TextField(
          decoration: new InputDecoration(labelText: "Search something"),
          controller: controller,
        ),
        Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                Size(10.0, 10.0);
                return filter == null || filter == ""
                    ? new Card(child: new Text(widget.items[index]))
                    : widget.items[index].contains(filter)
                        ? new Card(
                            child: new Text(
                            widget.items[index],
                            style: TextStyle(fontSize: 20.0),
                          ))
                        : new Container();
              }),
        )
      ],
    ));
  }
}
