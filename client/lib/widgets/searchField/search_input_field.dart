import 'package:flutter/material.dart';
import '../../bloc/bloc.dart';
import '../../bloc/provider.dart';

// Creates a input field

class SearchInputField extends StatefulWidget {
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  @override
  Bloc _bloc;
  Widget build(BuildContext context) {
    _bloc = Provider.of(context);

    return Material(
      child: Column(
        children: <Widget>[
          _renderTextInput(_bloc),
        ],
      ),
    );
  }

  // Text in input field are sent via streams to bloc
  Widget _renderTextInput(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: TextField(
            autofocus: false,
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
            keyboardType: TextInputType.text,
            onChanged: bloc.changeSearchBarInput,
          ),
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   _bloc.dispose();
  //   super.dispose();
  // }
}
