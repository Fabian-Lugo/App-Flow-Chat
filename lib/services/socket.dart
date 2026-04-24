import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:flow_chat/api/api_config.dart';
import 'package:flow_chat/features/auth/services/auth.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  io.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  io.Socket? get socket => _socket;

  final ApiConfig config = ApiConfigProd();

  void connectSocket() async {
    final token = await AuthService.getToken();

    _socket = io.io(
      config.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNew()
          .setExtraHeaders({'x-token': token ?? 'no-token'})
          .build(),
    );

    _socket!.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket!.onConnectError((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket!.onError((err) {
      debugPrint('Socket error: $err');
    });
  }

  void disconnectSocket() {
    _socket?.disconnect();
    _socket?.dispose();
    _serverStatus = ServerStatus.offline;
  }

  @override
  void dispose() {
    disconnectSocket();
    super.dispose();
  }
}
