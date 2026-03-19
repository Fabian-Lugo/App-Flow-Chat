import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/widgets/input_styles_border.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputStylePassword extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final bool useIcon;

  const InputStylePassword({
    super.key,
    required this.text,
    required this.controller,
    this.useIcon = false,
  });

  @override
  State<InputStylePassword> createState() => _InputStylePasswordState();
}

class _InputStylePasswordState extends State<InputStylePassword> {
  bool _obscureText = true;

  void _seePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) => setState((){}),
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: AppTextStyle.labelText,
        enabledBorder: InputStylesBorder.customBorder(color: AppColors.chatOffline),
        focusedBorder: InputStylesBorder.customBorder(color: AppColors.accentLight),
        errorBorder: InputStylesBorder.customBorder(color: AppColors.error),
        focusedErrorBorder: InputStylesBorder.customBorder(color: AppColors.errorLight),
        suffixIcon: Align(
          alignment: AlignmentGeometry.centerRight,
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 12),
            child: widget.controller.text.isNotEmpty
            ? GestureDetector(
              onTap: _seePassword,
              child: Icon(
                _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye
              ),
            )
            : Icon(CupertinoIcons.lock)
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