// import './adhara_socket_io.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import '../bloc/bloc.dart';

SocketIOManager manager = SocketIOManager();

startSocketConnection() async {
  SocketIO socket = await manager.createInstance('https://3298db41.ngrok.io');
  socket.onConnect((data) {
    print("connected...");
    print(data);
  });

  socket.on("answer", (data) {
    print(data);
    

    getUserFromSocket(data);
  });

  socket.connect();
}

