import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const TextLink({
    required this.text, 
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Text(text, style: AppTextStyle.linkText),
    );
  }
}
