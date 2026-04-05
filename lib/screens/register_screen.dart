import 'dart:io';

import 'package:flow_chat/widgets/checkbox_terms_style.dart';
import 'package:flow_chat/widgets/logo_image.dart';
import 'package:flow_chat/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/theme/app_routes.dart';
import 'package:flow_chat/widgets/input_style.dart';
import 'package:flow_chat/widgets/input_style_password.dart';
import 'package:flow_chat/widgets/button_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool aceptTerms = false;
  final _key = GlobalKey<FormState>();

  void goNext() {
    setState(() {
      if (_key.currentState!.validate()) {
        if (aceptTerms == true) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.inbox,
            (_) => false,
          );
        }
      }
    });
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
                          value: aceptTerms,
                          onChanged: (bool? newValue) => setState(() {
                            aceptTerms = newValue!;
                          }),
                        ),
                        Platform.isIOS
                            ? SizedBox(height: size.height * 0.05)
                            : SizedBox(height: size.height * 0.067),
                        ButtonStyles(text: 'Crear cuenta', onTap: goNext),
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
        TextLink(text: 'Inicia sesión', onTap: () => Navigator.pop(context)),
      ],
    );
  }
}
