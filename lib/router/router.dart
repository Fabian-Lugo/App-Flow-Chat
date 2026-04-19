import 'package:go_router/go_router.dart';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/router/app_routes.dart';
import 'package:flow_chat/features/chat/presentation/chat_screen.dart';
import 'package:flow_chat/features/chat/presentation/inbox_screen.dart';
import 'package:flow_chat/features/auth/presentation/login_screen.dart';
import 'package:flow_chat/features/chat/presentation/profile_screen.dart';
import 'package:flow_chat/features/auth/presentation/loading_screen.dart';
import 'package:flow_chat/features/auth/presentation/welcome_screen.dart';
import 'package:flow_chat/features/auth/presentation/register_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.loading,
  routes: [
    GoRoute(
      path: AppRoutes.loading,
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.inbox,
      builder: (context, state) => const InboxScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: AppRoutes.chat,
          builder: (context, state) =>
              ChatScreen(user: state.extra as UserModel?),
        ),
      ],
    ),
  ],
);
