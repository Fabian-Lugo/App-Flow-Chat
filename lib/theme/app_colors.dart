import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 1. Primary — acciones principales, botones, enlaces
  static const Color primary = Color(0xFF02569B);
  static const Color primaryLight = Color(0xFF0277BD);
  static const Color primaryDark = Color(0xFF013A6B);

  // 2. Surface — fondos y superficies
  static const Color surface = Color(0xFFF5F7FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF0D1117);

  // 3. Text — texto (3 tonos)
  static const Color text = Color(0xFF1A1F36);
  static const Color textLight = Color(0xFF5C6370);
  static const Color textDark = Color(0xFF0D1117);

  // 4. Accent — destacados, CTAs secundarios, estados activos
  static const Color accent = Color(0xFF00897B);
  static const Color accentLight = Color(0xFF4DB6AC);
  static const Color accentDark = Color(0xFF00695C);

  // 6. Chat: activo (online)
  static const Color chatActive = Color(0xFF4CAF50);
  static const Color chatActiveLight = Color(0xFF81C784);
  static const Color chatActiveDark = Color(0xFF2E7D32);

  // 7. Chat: offline
  static const Color chatOffline = Color(0xFF9E9E9E);
  static const Color chatOfflineLight = Color(0xFFBDBDBD);
  static const Color chatOfflineDark = Color(0xFF616161);

  // 8. Error — validaciones, mensajes de error, estados de error
  static const Color error = Color(0xFFC62828);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFB71C1C);
}
