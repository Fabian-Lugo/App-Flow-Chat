import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flow_chat/services/socket.dart';
import 'package:flow_chat/router/app_routes.dart';
import 'package:flow_chat/widgets/input_style.dart';
import 'package:flow_chat/utils/message_float.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/widgets/button_styles.dart';
import 'package:flow_chat/features/auth/services/auth.dart';
import 'package:flow_chat/widgets/input_style_password.dart';
import 'package:flow_chat/features/auth/widgets/text_link.dart';
import 'package:flow_chat/features/auth/widgets/logo_image.dart';
import 'package:flow_chat/features/auth/widgets/checkbox_terms_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool acceptTerms = false;

  void goNext() {
    final isFormValid = _key.currentState!.validate();

    if (!isFormValid) {
      setState(() {});
      return;
    }

    if (acceptTerms == false) {
      _showMessage(
        text: 'No aceptaste los términos y políticas',
        isError: true,
      );
      return;
    }

    _performRegister(
      _controllerName.text.trim(),
      _controllerEmail.text.trim(),
      _controllerPassword.text.trim(),
    );
  }

  void _performRegister(String name, String email, String password) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final signUpResult = await authService.signUp(name, email, password);

    if (signUpResult == SignUpResult.success) {
      _handleSuccess(socketService);
    } else {
      final text = signUpResult == SignUpResult.emailAlreadyRegistered
          ? 'Este correo ya está registrado. Inicia sesión con tu cuenta.'
          : 'Registro fallido';
      _showMessage(text: text, isError: true);
    }
  }

  void _handleSuccess(SocketService socketService) {
    _showMessage(text: 'Registro exitoso', isError: false);
    socketService.connectSocket();
    context.go(AppRoutes.inbox);
  }

  void _showMessage({required String text, required bool isError}) {
    MessageFloat.show(text: text, context: context, isError: isError);
  }

  @override
  void dispose() {
    _controllerName.dispose();
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
            child: Column(
              children: [
                Form(
                  key: _key,
                  child: Padding(
                    padding: Platform.isIOS
                        ? const EdgeInsets.symmetric(horizontal: 30)
                        : const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                    child: Column(
                      children: [
                        const _Header(),
                        const SizedBox(height: 30),
                        _inputFields(
                          nameController: _controllerName,
                          emailController: _controllerEmail,
                          passwordController: _controllerPassword,
                        ),
                        const SizedBox(height: 15),
                        CheckboxTermsStyle(
                          value: acceptTerms,
                          onChanged: (bool? newValue) => setState(() {
                            acceptTerms = newValue!;
                          }),
                        ),
                        Platform.isIOS
                            ? SizedBox(height: size.height * 0.05)
                            : SizedBox(height: size.height * 0.067),
                        ButtonStyles(
                          text: 'Crear cuenta',
                          onTap: goNext,
                          twoStyle: false,
                        ),
                        const SizedBox(height: 10),
                        const _loginFooter(),
                      ],
                    ),
                  ),
                ),
              ],
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
            ? Text('Únete a Flow Chat', style: AppTextStyle.titleIos)
            : Text('Únete a Flow Chat', style: AppTextStyle.title),
        const SizedBox(height: 10),
        Platform.isIOS
            ? Text(
                'Crea una cuenta gratis en 30 segundos',
                style: AppTextStyle.subtitleIos,
              )
            : Text(
                'Crea una cuenta gratis en 30 segundos',
                style: AppTextStyle.subtitle,
              ),
      ],
    );
  }
}

class _inputFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _inputFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputStyle(
          title: 'Nombre',
          hintText: 'Ingrese nombre completo',
          controller: nameController,
          type: TextInputType.text,
          useIcon: Icon(Icons.person_2_outlined),
          readOnly: false,
        ),
        const SizedBox(height: 13),
        InputStyle(
          title: 'Correo',
          hintText: 'Ingrese correo',
          controller: emailController,
          type: TextInputType.emailAddress,
          useIcon: Icon(Icons.mail_outline_rounded),
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

class _loginFooter extends StatelessWidget {
  const _loginFooter();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Ya eres miembro?', style: AppTextStyle.body),
        const SizedBox(width: 3),
        TextLink(text: 'Inicia sesión', onTap: () => context.pop()),
      ],
    );
  }
}
