// import './adhara_socket_io.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

void connect() async {
  SocketIOManager manager = SocketIOManager();
  SocketIO socket = await manager.createInstance('https://7673c650.ngrok.io');
  socket.onConnect((data) {
    print("connected...");
    print(data);
    socket.emit("message", ["Hello world!"]);
  });
  socket.on("answer", (data) {
    //sample event
    print("answer6");
    print(data);
  });
  socket.connect();

  ///disconnect using
  ///manager.
}
