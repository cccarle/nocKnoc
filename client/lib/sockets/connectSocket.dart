// import './adhara_socket_io.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class Socket {
  get accesSocket => _instanciateSocket;
  // get connectSocket => _connectSocket;
  // get listenOnSocket => _listenOnSocket;

  SocketIOManager manager = SocketIOManager();

  _instanciateSocket() async {
    SocketIO socket = await manager.createInstance('https://5fb4b410.ngrok.io');
    return socket.connect();
  }

  // _connectSocket() async {
  //   SocketIO socket = await _instanciateSocket();
  //   socket.connect();
  //   socket.onConnect((data) {
  //     print("connected...");
  //     print(data);
  //   });
  // }

  // _listenOnSocket() async {
  //   SocketIO socket = await _instanciateSocket();
  //   socket.connect();
  //   socket.on("answer", (data) {
  //     //sample event
  //     print("answer6");
  //     print(data);
  //   });
  // }
}

Socket socket = new Socket();

//
