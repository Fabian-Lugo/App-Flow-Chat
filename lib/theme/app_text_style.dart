import 'package:flow_chat/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // Welcome Screen
  static TextStyle welcomeTitle = GoogleFonts.inter(
    fontSize: 23,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle welcomeSubtitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: AppColors.text,
  );

  static TextStyle developerText = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.text,
  );

  static TextStyle githubName = GoogleFonts.inter(
    fontSize: 15,
    color: AppColors.surfaceDark,
  );

  // Login Screen
  static TextStyle loginTitle = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle labelText = GoogleFonts.inter(
    color: AppColors.text,
  );

  static TextStyle checkboxText = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );

  static TextStyle linkText = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  // Buttons
  static TextStyle buttonTextPrimary = GoogleFonts.inter(
    fontSize: 15,
    color: AppColors.surfaceLight,
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonTextSecondary = GoogleFonts.inter(
    fontSize: 15,
    color: AppColors.primaryLight,
    fontWeight: FontWeight.w500,
  );
}
