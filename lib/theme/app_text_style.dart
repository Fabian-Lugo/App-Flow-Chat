import 'package:flow_chat/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // --- Títulos y Encabezados ---
  static TextStyle title = GoogleFonts.inter(
    fontSize: 27,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle titleIos = GoogleFonts.inter(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle subtitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
  );

  static TextStyle subtitleIos = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
  );

  static TextStyle heading = GoogleFonts.inter(
    fontSize: 23,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle headingSmall = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  // --- Cuerpo y Etiquetas ---
  static TextStyle body = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.text,
  );

  static TextStyle label = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static TextStyle labelBold = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle inputsTitle = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.surfaceDark,
  );

  // --- Enlaces y Botones ---
  static TextStyle link = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle buttonPrimary = GoogleFonts.inter(
    fontSize: 15,
    color: AppColors.surfaceLight,
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonSecondary = GoogleFonts.inter(
    fontSize: 15,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  // --- Especializados ---
  static TextStyle appBarTitle = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle avatarInitials = GoogleFonts.inter(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: AppColors.surfaceLight,
  );
  static TextStyle profileInitials = GoogleFonts.inter(
    fontSize: 60,
    fontWeight: FontWeight.w600,
    color: AppColors.surfaceLight,
  );

  static TextStyle statusSmall = GoogleFonts.inter(
    fontSize: 10,
    color: AppColors.surfaceLight,
  );

  // --- Chat ---
  static TextStyle chatMessage = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.surfaceLight,
  );

  static TextStyle chatInputHint = GoogleFonts.inter(
    color: AppColors.darkBorder,
    fontWeight: FontWeight.w500,
  );

  static TextStyle chatInputLabel = GoogleFonts.inter(
    color: AppColors.darkCard,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static TextStyle chatSendButton = GoogleFonts.inter(
    color: AppColors.primary,
    fontWeight: FontWeight.w600,
  );
}
