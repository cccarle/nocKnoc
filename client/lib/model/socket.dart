import 'dart:async';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class Socket  {

  get connectSocket => _connectSocket;

   _connectSocket() async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance('https://e2d8152d.ngrok.io');
    return socket;
  }
}

Socket socket = new Socket();