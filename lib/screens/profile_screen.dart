import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_routes.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/widgets/button_styles.dart';
import 'package:flow_chat/widgets/input_style.dart';
import 'package:flow_chat/widgets/user_avatar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  const ProfileScreen({this.user, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<User> users = [
    User(uid: '1', name: 'Fabian', email: 'fabian@flow.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _AppBarTitle(),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.chevron_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _AvatarRow(users: users),
            const SizedBox(height: 30),
            Text(users[0].name, style: AppTextStyle.titleIos),
            const SizedBox(height: 10),
            Text('Información de perfil', style: AppTextStyle.subtitleIos),
            const SizedBox(height: 30),
            _InfoFields(users: users),
            SizedBox(height: MediaQuery.of(context).size.height * 0.16),
            ButtonStyles(
              text: 'Cerrar sesión',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (_) => false,
              ),
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
  final List<User> users;
  const _AvatarRow({required this.users});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserAvatarStyle(
          user: users[0],
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
  final List<User> users;
  const _InfoFields({required this.users});

  @override
  State<_InfoFields> createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<_InfoFields> {
  bool isOnline = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputStyle(
          title: 'Correo',
          hintText: widget.users[0].email,
          controller: TextEditingController(),
          type: TextInputType.text,
          useIcon: Icon(Icons.mail_outline_outlined),
          readOnly: true,
        ),
        const SizedBox(height: 13),
        InputStyle(
          title: 'Estado',
          hintText: isOnline ? 'En línea' : 'Offline',
          controller: TextEditingController(),
          type: TextInputType.text,
          useIcon: _iconOnline(isOnline),
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
