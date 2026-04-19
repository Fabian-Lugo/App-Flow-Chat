import 'package:flutter/material.dart';

import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';

class CheckboxTermsStyle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxTermsStyle({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: AppColors.surfaceDark, width: 2),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Acepta los ', style: AppTextStyle.body),
                TextSpan(
                  text: 'Términos de Servicio ',
                  style: AppTextStyle.link,
                ),
                TextSpan(text: 'y ', style: AppTextStyle.body),
                TextSpan(
                  text: 'Política de Privacidad',
                  style: AppTextStyle.link,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
