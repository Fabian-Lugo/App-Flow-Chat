import 'package:flutter/material.dart';

import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';

enum ConnectionStateStyle { connected, disconnected, connecting }

class ConnectionStyles extends StatelessWidget {
  final ConnectionStateStyle state;

  const ConnectionStyles({
    this.state = ConnectionStateStyle.connected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final String text;
    final Color backgroundColor;

    switch (state) {
      case ConnectionStateStyle.connected:
        icon = Icons.wifi;
        text = 'Conectado';
        backgroundColor = AppColors.accentLight;
        break;
      case ConnectionStateStyle.disconnected:
        icon = Icons.wifi_off;
        text = 'Desconectado';
        backgroundColor = AppColors.errorLight;
        break;
      case ConnectionStateStyle.connecting:
        icon = Icons.sync;
        text = 'Conectando';
        backgroundColor = AppColors.text;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.surfaceLight, size: 15),
          const SizedBox(width: 5),
          Text(text, style: AppTextStyle.statusSmall),
        ],
      ),
    );
  }
}
