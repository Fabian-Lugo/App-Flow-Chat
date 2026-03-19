import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/widgets/input_styles_border.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class InputStyle extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType type;
  final IconData useIcon;

  const InputStyle({
    super.key,
    required this.text,
    required this.controller,
    required this.type,
    required this.useIcon,
  });

  @override
  State<InputStyle> createState() => _InputStyleState();
}

class _InputStyleState extends State<InputStyle> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: AppTextStyle.labelText,
        enabledBorder: InputStylesBorder.customBorder(color: AppColors.chatOffline),
        focusedBorder: InputStylesBorder.customBorder(color: AppColors.accentLight),
        errorBorder: InputStylesBorder.customBorder(color: AppColors.error),
        focusedErrorBorder: InputStylesBorder.customBorder(color: AppColors.error),
        suffixIcon: Align(
          alignment: AlignmentGeometry.centerRight,
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(widget.useIcon)
          ),
        )
      ),
      validator: (value) => 
        (value?.trim().isEmpty ?? true)
        ? 'Completa el campo'
        : null,
    );
  }
}