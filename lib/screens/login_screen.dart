import 'package:flow_chat/widgets/checkbox_style.dart';
import 'package:flow_chat/widgets/logo_image.dart';
import 'package:flow_chat/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/theme/app_assets.dart';
import 'package:flow_chat/theme/app_routes.dart';
import 'package:flow_chat/utils/input_style.dart';
import 'package:flow_chat/utils/input_style_password.dart';
import 'package:flow_chat/widgets/button_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerText = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  void goNext() {
    if (_key.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    }
  }

  @override
  void dispose() {
    _controllerText.dispose();
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        LogoImage(),
                        Text(
                          'Inicia sesión',
                          style: AppTextStyle.loginTitle,
                        ),
                        const SizedBox(height: 30),
                        InputStyle(
                          text: 'Correo',
                          controller: _controllerText,
                          type: TextInputType.emailAddress,
                          useIcon: CupertinoIcons.mail,
                        ),
                        const SizedBox(height: 20),
                        InputStylePassword(
                          text: 'Contraseña',
                          controller: _controllerPassword,
                        ),
                        const SizedBox(height: 15),
                        _loginOptions(),
                        SizedBox(height: size.height * 0.2),
                        ButtonStyles(text: 'Iniciar sesión', onTap: goNext),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No tienes cuenta?'),
                            const SizedBox(width: 3),
                            TextLink(text: 'Unete ahora', onTap: () => print('Usuario: registrar'))
                          ],
                        )
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

  Widget _loginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CheckboxStyle(text: 'Recordarme'),
        TextLink(text: 'Cambiar contraseña', onTap: () => print('Usuario: cambiar contraseña'))
      ],
    );
  }
}
