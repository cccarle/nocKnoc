import 'package:flutter/material.dart';
import '../widgets/searchField/search_input_field.dart';
import '../widgets/userList/user_list_builder.dart';
import '../widgets/appbar/app_bar.dart';
import '../bloc/provider.dart';
import '../API/api.dart';
import 'dart:async';
import '../model/user_model.dart';
import '../widgets/modals/alternative_contact.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import '../pages/error_page.dart';
import '../config/globals.dart' as globals;

class SearchPage extends StatefulWidget {
  final String visitor;
  final dynamic apiKey;

  SearchPage({this.visitor, this.apiKey});

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<UserModel>> list;
  // List<UserModel> test;
  static final showSmallContainer = 600.0;
  static final showLargeContainer = 290.0;
  double _height = showSmallContainer;

  @protected
  void initState() {
    super.initState();
    returnList();
    checkIfKeyboardIsDisplayed();
  }

  void goBackToHomeScreen() {
    Future.delayed(
      const Duration(minutes: 4),
      () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  void checkIfKeyboardIsDisplayed() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          _height = showLargeContainer;
        } else {
          _height = showSmallContainer;
        }
      },
    );
  }

  returnList() {
    if (list == null) {
      // var res = await fecthUserList(widget.apiKey);
      print(list);
      setState(
        () {
          list = fecthUserList(widget.apiKey);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    goBackToHomeScreen();
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
          child: pageBuilder(context, bloc),
        ),
      ),
    );
  }

  pageBuilder(BuildContext context, bloc) {
    return Column(
      children: <Widget>[
        _headlineText(),
        _searchInput(),
        SizedBox(height: 25),
        _listViewSlackUsers(context, bloc),
        AlternativeContact(widget.visitor)
      ],
    );
  }
  // if (test != null) {
  //   return Column(
  //     children: <Widget>[
  //       _headlineText(),
  //       _searchInput(),
  //       SizedBox(height: 25),
  //       _listViewSlackUsers(context, bloc),
  //       AlternativeContact(widget.visitor)
  //     ],
  //   );
  // } else {
  //   return ErrorPage();
  // }

  Widget _headlineText() {
    return Center(
      child: Text(
        globals.whoAreYouLookingFor,
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
        child: UserListBuilder(widget.visitor, list, (_height - 50), context));
  }
}
