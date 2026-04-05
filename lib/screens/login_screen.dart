import 'dart:io';

import 'package:flow_chat/widgets/logo_image.dart';
import 'package:flow_chat/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/theme/app_routes.dart';
import 'package:flow_chat/widgets/input_style.dart';
import 'package:flow_chat/widgets/input_style_password.dart';
import 'package:flow_chat/widgets/button_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void goNext() {
    setState(() {
      if (_key.currentState!.validate()) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.inbox,
          (_) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Padding(
                padding: Platform.isIOS
                    ? const EdgeInsets.symmetric(horizontal: 30)
                    : const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    const _Header(),
                    SizedBox(height: 30),
                    _InputFields(
                      emailController: _controllerEmail,
                      passwordController: _controllerPassword,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextLink(
                          text: '¿Olvidaste tu contraseña?',
                          onTap: () => print('Usuario: cambiar contraseña'),
                        ),
                      ],
                    ),
                    Platform.isIOS
                        ? SizedBox(height: size.height * 0.191)
                        : SizedBox(height: size.height * 0.195),
                    ButtonStyles(text: 'Iniciar sesión', onTap: goNext),
                    const SizedBox(height: 10),
                    const _RegisterFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogoImage(),
        Platform.isIOS
            ? Text('¡Bienvenido nuevamente!', style: AppTextStyle.titleIos)
            : Text('¡Bienvenido nuevamente!', style: AppTextStyle.title),
        const SizedBox(height: 10),
        Platform.isIOS
            ? Text(
                'Continuemos donde lo dejaste',
                style: AppTextStyle.subtitleIos,
              )
            : Text(
                'Continuemos donde lo dejaste',
                style: AppTextStyle.subtitle,
              ),
      ],
    );
  }
}

class _InputFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _InputFields({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputStyle(
          title: 'Correo',
          hintText: 'Ingrese correo',
          controller: emailController,
          type: TextInputType.emailAddress,
          useIcon: Icon(Icons.mail_outline_outlined),
          readOnly: false,
        ),
        const SizedBox(height: 13),
        InputStylePassword(
          title: 'Contraseña',
          hintText: 'Ingrese contraseña',
          controller: passwordController,
        ),
      ],
    );
  }
}

class _RegisterFooter extends StatelessWidget {
  const _RegisterFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No tienes cuenta?'),
            const SizedBox(width: 3),
            TextLink(
              text: 'Unete ahora',
              onTap: () => Navigator.pushNamed(context, AppRoutes.register),
            ),
          ],
        ),
      ],
    );
  }
}
