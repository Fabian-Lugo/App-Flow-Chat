import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flow_chat/theme/app_colors.dart';

class MessageFloat {
  static void show({
    required String text,
    required BuildContext context,
    required bool isError,
  }) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _MessageScreen(
        text: text,
        icon: isError ? Icons.cancel_outlined : Icons.check_circle_outline,
        isError: isError,
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 1500), () {
      overlayEntry.remove();
    });
  }
}

class _MessageScreen extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isError;

  const _MessageScreen({
    required this.text,
    required this.icon,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isError ? AppColors.error : AppColors.chatActive,
              borderRadius: BorderRadius.circular(
                30,
              ), // Bordes bien redondeados
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.surfaceLight, size: 24),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.surfaceLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
