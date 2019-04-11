import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  final List<String> people;

  ListItems(this.people);
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[Text(widget.people[index])],
      ),
    );
  }

  Widget _buildProductList() {
    print(widget.people);
    Widget productCards;
    if (widget.people.length > 0) {
      productCards = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: _buildProductItem,
        itemCount: widget.people.length,
      );
    } else {
      productCards = Center(
        child: Text('No products found'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[products widget] build');
    return _buildProductList();
  }
}
