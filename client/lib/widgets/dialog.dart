import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../model/user_model.dart';
import '../bloc/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './alertIcon.dart';
import './spinner.dart';
import 'dart:math';
import 'dart:ui';
import '../widgets/dialog_content.dart';
import './my_painter.dart';

class Dialog {
  get getDialog => _showDialog;
  get getCancelDialog => _cancelDialog;
  get alternativeDialog => _alternativeDialog;

  Future<bool> _showDialog(BuildContext context, UserModel user) async {
    SocketIOManager manager = SocketIOManager();
    final SocketIO socket =
        await manager.createInstance('https://6da3b5c7.ngrok.io');
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          )),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: new Container(
            height: 350.0,
            width: 400.0,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: new Stack(
                    // fit: StackFit.loose,
                    children: <Widget>[
                      new Positioned(
                        child: Center(
                          child: SpinKitRing(
                              color: Theme.of(context).accentColor,
                              size: 135.0,
                              lineWidth: 15.0),
                        ),
                      ),
                      new Positioned(
                        // left: MediaQuery.of(context).size.width * 0.40,
                        child: Padding(
                          padding: EdgeInsets.only(top: 13.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                child: Image.network(
                                  user.image,
                                  fit: BoxFit.fill,
                                  height: 110.0,
                                  width: 110.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                DialogContent(socket, user.name, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _alternativeDialog(BuildContext context) async {

    SocketIOManager manager = SocketIOManager();
    final SocketIO socket =
        await manager.createInstance('https://6da3b5c7.ngrok.io');
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          )),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: new Container(
            height: 350.0,
            width: 400.0,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: new Stack(
                    // fit: StackFit.loose,
                    children: <Widget>[
                      new Positioned(
                        child: Center(
                          child: SpinKitRing(
                              color: Theme.of(context).accentColor,
                              size: 135.0,
                              lineWidth: 15.0),
                        ),
                      ),
                      new Positioned(
                        // left: MediaQuery.of(context).size.width * 0.40,
                        child: Padding(
                          padding: EdgeInsets.only(top: 13.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                child: Image.network(
                                 "https://media.licdn.com/dms/image/C4D0BAQEFDQEvVnNIFQ/company-logo_200_200/0?e=2159024400&v=beta&t=rbi_4pyBeBBlPqqQaWMHUWOE9Q0vwIZV2iN_RS5fOWA",
                                  fit: BoxFit.fill,
                                  height: 110.0,
                                  width: 110.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                DialogContent(socket, "asd", context),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _cancelDialog(
      BuildContext context, makeRequest, timer, setTimer, apiKey) async {
    _handleOnTapEvent(BuildContext context) {
      makeRequest(apiKey);
      setTimer(0);
      Navigator.of(context).pop(true);
    }

    _handleCancelEvent(BuildContext context, timer) {
      timer.cancel();
      setTimer(3000);
      Navigator.of(context).pop(true);
    }

    _onTapImage(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              new Positioned(
                child: Center(
                  child: SpinKitRing1(
                      duration: const Duration(milliseconds: 5500),
                      color: Theme.of(context).accentColor,
                      size: 135.0,
                      lineWidth: 6.0),
                ),
              ),
              new Positioned(
                child: Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: GestureDetector(
                          onTap: () => _handleOnTapEvent(context),
                          child: AlertIcon(size: 80, color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton.icon(
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () => _handleCancelEvent(context, timer),
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                label: Text('Avbryt')),
          ),
        ],
      );
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) => _onTapImage(context));
  }
}

Dialog dialog = new Dialog();
