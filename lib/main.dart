import 'package:flutter/material.dart';
import 'package:flow_chat/theme/app_routes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flow-chat',
      initialRoute: AppRoutes.welcome,
      routes: appRoutes,
    );
  }
}
