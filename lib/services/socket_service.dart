import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse("ws://localhost:8000/ws/bookings"),
  );

  Stream<Map<String, dynamic>> get bookingStream =>
      channel.stream.map((event) => jsonDecode(event));
}
