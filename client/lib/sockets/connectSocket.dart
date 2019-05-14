// // import './adhara_socket_io.dart';
// import 'package:adhara_socket_io/adhara_socket_io.dart';
// import '../bloc/provider.dart';

// startSocketConnection() async {
//   SocketIO socket = await manager.createInstance('https://3298db41.ngrok.io');
//   socket.onConnect((data) {
//     print("connected...");
//     print(data);
//   });

//   socket.on("answer", (data) {
//     print(data);
//   });

//   socket.connect();
// }

// SocketIOManager manager = SocketIOManager();

// class Socket {
//   static getSocket() async {

//     return socket;
//   }

//   static test(context) async {
//    final bloc = Provider.of(context);
//     SocketIO socket = await getSocket();
//     socket.on("answer", (data) {
//       print('asd');
//       bloc.getUserFromSocket.add(data);
//     });
//   }
// }
