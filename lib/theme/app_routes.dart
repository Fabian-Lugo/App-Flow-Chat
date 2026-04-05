import 'package:flutter/material.dart';
import 'package:flow_chat/screens/welcome_screen.dart';
import 'package:flow_chat/screens/login_screen.dart';
import 'package:flow_chat/screens/register_screen.dart';
import 'package:flow_chat/screens/inbox_screen.dart';
import 'package:flow_chat/screens/chat_screen.dart';
import 'package:flow_chat/screens/profile_screen.dart';

abstract class AppRoutes {
  AppRoutes._();
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String inbox = 'inbox';
  static const String chat = 'chat';
  static const String profile = 'profile';
}

final Map<String, Widget Function(BuildContext)> appRoutes = {
  AppRoutes.welcome: (_) => const WelcomeScreen(),
  AppRoutes.login: (_) => const LoginScreen(),
  AppRoutes.register: (_) => const RegisterScreen(),
  AppRoutes.inbox: (_) => const InboxScreen(),
  AppRoutes.chat: (_) => const ChatScreen(),
  AppRoutes.profile: (_) => const ProfileScreen(),
};
