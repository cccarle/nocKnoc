import 'package:flutter/material.dart';
import 'bloc.dart';

/* 
Provider is wrapped around the application for accessing the bloc anywhere in the app
Provider is accessed by using "final bloc = Provider.of(context);"
 */

class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
