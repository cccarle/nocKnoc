import 'package:flutter/material.dart';
import '../widgets/searchInputField.dart';
import '../widgets/listView.dart';
import '../widgets/appBar.dart';
import '../bloc/provider.dart';
import '../API/api.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class SearchPage extends StatefulWidget {
  final String visitor;

  SearchPage(this.visitor);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double _height = 650;
  @protected
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          _height = 300;
        } else {
          _height = 650;
        }
        print(visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final Future<List<UserModel>> list = ;
    final bloc = Provider.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: DynamicAppBar(),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 700.0,
            child: Column(
              children: <Widget>[
                _headlineText(),
                _searchInput(),
                SizedBox(height: 25),
                _listViewSlackUsers(context, bloc),
              ],
            ),
          ),
        ));
  }

  Widget _headlineText() {
    return Center(
      child: Text(
        'Vem söker du?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 80.0, color: Colors.white),
      ),
    );
  }

  Widget _searchInput() {
    return Container(
      width: 440,
      child: SearchInputField(),
    );
  }

  Widget _listViewSlackUsers(BuildContext context, bloc) {
    return Container(
        height: _height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListViewSlackUsers(
            widget.visitor, fecthUserList(), (_height - 50), context));
  }
}
