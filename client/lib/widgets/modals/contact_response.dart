import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class ContactResponse extends StatefulWidget {
  final BuildContext context;
  final SocketIO socket;
  final String image;
  final String username;

  ContactResponse(
      {this.context,
      this.socket,
      this.image =
          "https://media.licdn.com/dms/image/C4D0BAQEFDQEvVnNIFQ/company-logo_200_200/0?e=2159024400&v=beta&t=rbi_4pyBeBBlPqqQaWMHUWOE9Q0vwIZV2iN_RS5fOWA",
      this.username = ""});
  _ContactResponseState createState() => _ContactResponseState();
}

class _ContactResponseState extends State<ContactResponse> {
  bool _answer = false;
  bool _showImage = true;
  String _image;

  @override
  void initState() {
    super.initState();
    _listenOnSocket();
    setState(() => {_image = widget.image});
  }

  void _listenOnSocket() {
    widget.socket.on('answer', (data) {
      this.setState(() => {_answer = true, _image = data['pic']});
    });
  }

  Widget _buildStack(BuildContext context) {
    var spinner = _answer
        ? Container()
        : new Positioned(
            child: Center(
              child: SpinKitRing(
                  color: Theme.of(context).accentColor,
                  size: 135.0,
                  lineWidth: 15.0),
            ),
          );

    var picture = _showImage
        ? new Positioned(
            child: Padding(
              padding: EdgeInsets.only(top: 13.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    child: Image.network(
                      _image,
                      fit: BoxFit.fill,
                      height: 110.0,
                      width: 110.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();

    return Stack(
      children: <Widget>[spinner, picture, Container()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildStack(context);
  }
}
