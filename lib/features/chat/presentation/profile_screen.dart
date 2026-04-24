import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/services/socket.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/router/app_routes.dart';
import 'package:flow_chat/widgets/input_style.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/widgets/button_styles.dart';
import 'package:flow_chat/features/auth/services/auth.dart';
import 'package:flow_chat/features/chat/widgets/user_avatar_style.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel? user;
  const ProfileScreen({this.user, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.isSignedIn();
    super.initState();
  }

  void _signOut() async {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.disconnectSocket();
    AuthService.deleteToken();
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: const _AppBarTitle(),
        elevation: 1,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(CupertinoIcons.chevron_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _AvatarRow(authService: authService),
            const SizedBox(height: 30),
            Text(user!.name, style: AppTextStyle.titleIos),
            const SizedBox(height: 10),
            Text('Información de perfil', style: AppTextStyle.subtitleIos),
            const SizedBox(height: 30),
            _InfoFields(authService: authService),
            Platform.isIOS
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.16)
                : SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            ButtonStyles(
              text: 'Cerrar sesión',
              onTap: _signOut,
              twoStyle: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text('Perfil', style: AppTextStyle.appBarTitle)]);
  }
}

class _AvatarRow extends StatelessWidget {
  final AuthService authService;
  const _AvatarRow({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserAvatarStyle(
          user: authService.user!,
          radius: 80,
          showBadge: false,
          useAccentGradient: false,
          profileStyle: true,
          profileInitials: true,
        ),
      ],
    );
  }
}

class _InfoFields extends StatefulWidget {
  final AuthService authService;
  const _InfoFields({required this.authService});

  @override
  State<_InfoFields> createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<_InfoFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputStyle(
          title: 'Correo',
          hintText: widget.authService.user!.email,
          controller: TextEditingController(),
          type: TextInputType.text,
          useIcon: Icon(Icons.mail_outline_outlined),
          readOnly: true,
        ),
        const SizedBox(height: 13),
        InputStyle(
          title: 'Estado',
          hintText: widget.authService.user!.online
              ? 'En línea'
              : 'Desconectado',
          controller: TextEditingController(),
          type: TextInputType.text,
          useIcon: _iconOnline(widget.authService.user!.online),
          readOnly: true,
        ),
      ],
    );
  }

  Icon _iconOnline(bool isOnline) {
    return isOnline
        ? Icon(Icons.check_circle_outline, color: AppColors.chatActive)
        : Icon(Icons.cancel_outlined, color: AppColors.error);
  }
}
