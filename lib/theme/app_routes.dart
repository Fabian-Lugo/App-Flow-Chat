import 'package:flow_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

/// Nombres de rutas para evitar strings mágicos.
abstract class AppRoutes {
  AppRoutes._();
  static const String welcome = 'welcome';
  //static const String login = 'login';
  //static const String register = 'register';
  //static const String chat = 'chat';
  //static const String users = 'users';
}

final Map<String, Widget Function(BuildContext)> appRoutes = {
  AppRoutes.welcome: (_) => WelcomeScreen(),
  //AppRoutes.login: (_) => const LoginScreen(),
  //AppRoutes.register: (_) => const RegisterScreen(),
  //AppRoutes.chat: (_) => const RegisterScreen(),
  //AppRoutes.users: (_) => const RegisterScreen(),
};