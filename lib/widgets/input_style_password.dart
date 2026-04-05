import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/utils/input_styles_border.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class InputStylePassword extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool useIcon;

  const InputStylePassword({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.useIcon = false,
  });

  @override
  State<InputStylePassword> createState() => _InputStylePasswordState();
}

class _InputStylePasswordState extends State<InputStylePassword> {
  bool _obscureText = true;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();

  void _seePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = _fieldKey.currentState?.hasError ?? false;

    return Column(
      children: [
        Align(
          alignment: AlignmentGeometry.centerStart,
          child: Padding(
            padding: EdgeInsetsGeometry.only(bottom: 8),
            child: Text(widget.title, style: AppTextStyle.inputsTitle),
          ),
        ),
        TextFormField(
          key: _fieldKey,
          controller: widget.controller,
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            _fieldKey.currentState?.validate();
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelStyle: AppTextStyle.label,
            errorStyle: const TextStyle(height: 0.1, fontSize: 0),
            enabledBorder: InputStylesBorder.customBorder(
              color: AppColors.chatOffline,
            ),
            focusedBorder: InputStylesBorder.customBorder(
              color: AppColors.accentLight,
            ),
            errorBorder: InputStylesBorder.customBorder(color: AppColors.error),
            focusedErrorBorder: InputStylesBorder.customBorder(
              color: AppColors.errorLight,
            ),
            prefixIcon: Align(
              alignment: AlignmentGeometry.centerLeft,
              widthFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: const Icon(Icons.lock_outline_rounded),
              ),
            ),
            suffixIcon: Align(
              alignment: AlignmentGeometry.centerRight,
              widthFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: hasError
                    ? const Icon(Icons.error, color: AppColors.error)
                    : (widget.controller.text.isNotEmpty
                          ? GestureDetector(
                              onTap: _seePassword,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            )
                          : null),
              ),
            ),
          ),
          validator: (value) => (value?.trim().isEmpty ?? true) ? '' : null,
        ),
      ],
    );
  }
}
