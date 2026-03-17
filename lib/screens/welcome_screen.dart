import 'package:flow_chat/theme/app_assets.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/widgets/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 33),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.welcomeImage,
                    width: 320,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05 ),
            Text('¡Bienvenido a Flow Chat!',
              style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.w700, color: AppColors.text),
            ),
            const SizedBox(height: 15),
            Text('Nos complace presentar Flow chat\nsencillo, rápido y la forma más práctica\nde hablar.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w300, color: AppColors.text),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Expanded(
                  child: Divider(color: AppColors.chatOfflineLight, thickness: 1, endIndent: 10)
                ),
                Text('Desarrollado por',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.text),
                ),
                const Expanded(
                  child: Divider(color: AppColors.chatOfflineLight, thickness: 1, indent: 10)
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.surfaceDark, width: 0.5)
                  ), child: Row(
                    children: [
                      Image.asset(AppAssets.githubLogo, width: 20),
                      const SizedBox(width: 5),
                      Text('Fabian',
                          style: GoogleFonts.inter(fontSize: 15, color: AppColors.surfaceDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height *0.05),
            ButtonStyles(text: 'Iniciar sesión', onTap: () => debugPrint('Usuario: iniciar sesión')),
            const SizedBox(height: 20),
            ButtonStyles(text: 'Crear cuenta', twoStyle: true, onTap: () => debugPrint('Usuario: crear cuenta'),),
          ],
        ),
      ),
    );
  }
}