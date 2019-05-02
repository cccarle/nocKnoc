import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../bloc/provider.dart';

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Material(
      child: Column(
        children: <Widget>[
          renderTextInput(bloc),
        ],
      ),
    );
  }

  Widget renderTextInput(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.none,
                  ),
                ),
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white),
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeSearchBarInput,
          ),
        );
      },
    );
  }
}
