import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import '../../config/globals.dart' as globals;

// On reponse from socket the picture is changed
class ContactResponse extends StatefulWidget {
  final BuildContext context;
  final SocketIO socket;
  final String image;
  final String username;

  ContactResponse(
      {this.context,
      this.socket,
      this.image = globals.defaultImage,
      this.username = globals.emptyString});

  _ContactResponseState createState() => _ContactResponseState();
}

class _ContactResponseState extends State<ContactResponse> {
  bool _hasAnswerFromSocket = false;
  bool _showImage = true;

  String _image;

  @override
  void initState() {
    super.initState();
    _listenOnSocket();

    setState(() => {_image = widget.image});
  }

  void _listenOnSocket() {
    widget.socket.on('answer', (responseFromSocket) {
      this.setState(
        () => {
              _hasAnswerFromSocket = true,
              _image = responseFromSocket['pic'],
            },
      );
    });
  }

  Widget loadingSpinner() {
    return Positioned(
      child: Center(
        child: SpinKitRing(
            color: Theme.of(context).accentColor, size: 135.0, lineWidth: 15.0),
      ),
    );
  }

  Widget loadImage() {
    return Positioned(
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
    );
  }

  Widget _buildContactResponse(BuildContext context) {
    var spinner = _hasAnswerFromSocket ? Container() : loadingSpinner();

    var image = _showImage ? loadImage() : Container();

    return Stack(
      children: <Widget>[spinner, image, Container()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContactResponse(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
