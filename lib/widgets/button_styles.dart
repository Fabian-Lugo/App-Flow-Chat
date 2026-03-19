import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ButtonStyles extends StatelessWidget{
  final String text;
  final bool twoStyle;
  final VoidCallback onTap;

  const ButtonStyles({
    super.key,
    required this.text,
    required this.onTap,
    this.twoStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: twoStyle ? AppColors.surfaceLight : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(15),
          border: twoStyle ? Border.all(color: AppColors.primaryLight, width: 1) : null,
        ), child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
              style: twoStyle ? AppTextStyle.buttonTextSecondary : AppTextStyle.buttonTextPrimary,
            ),
          ],
        )
      ),
    );
  }
}