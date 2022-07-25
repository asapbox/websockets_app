import 'package:web_socket_channel/web_socket_channel.dart';


class ApiWebSocket {
  static final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
}
