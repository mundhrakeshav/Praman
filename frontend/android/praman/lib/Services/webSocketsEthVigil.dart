import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketsEthVigil extends ChangeNotifier {
  List pendingTxs = [];

  static const String url = "wss://beta.ethvigil.com/ws";
  static const String key = "a03b152a-856e-4351-9884-26497e14690a";
  static String sessionID;

  static WebSocketChannel channel =
      IOWebSocketChannel.connect(url, pingInterval: Duration(seconds: 20));

  initialise() {
    channel.stream.listen((event) {
      var data = jsonDecode(event);
      print(data);

      sessionID = data["sessionID"];
      print(sessionID);
    });

    channel.sink.add(jsonEncode({
      "command": "register",
      "key": key,
    }));
  }

  WebSocketsEthVigil() {
    initialise();
  }
}
