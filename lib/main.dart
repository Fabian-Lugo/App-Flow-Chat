import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flow_chat/router/router.dart';
import 'package:flow_chat/services/socket.dart';
import 'package:flow_chat/features/auth/services/auth.dart';
import 'package:flow_chat/features/chat/services/messages.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => MessagesService()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flow-chat',
      ),
    );
  }
}
