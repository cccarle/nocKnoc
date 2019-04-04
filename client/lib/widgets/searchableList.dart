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
          padding: EdgeInsets.only(bottom: 20.0),
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 10,
                  style: BorderStyle.none,
                ),
              ),
              labelStyle: TextStyle(color: Colors.yellow),
              filled: true,
              fillColor: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {},
          controller: controller,
        ),
        Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return filter == null || filter == ""
                    ? Card(
                        child: Text(widget.items[index],
                            style: TextStyle(fontSize: 40.0)))
                    : widget.items[index]
                            .toLowerCase()
                            .contains(filter.toString())
                        ? Card(
                            child: Text(
                            widget.items[index],
                            style: TextStyle(fontSize: 40.0),
                          ))
                        : Container();
              }),
        )
      ],
    ));
  }
}
