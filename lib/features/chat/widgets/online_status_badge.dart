import 'package:flutter/material.dart';

import 'package:flow_chat/theme/app_colors.dart';

class OnlineStatusBadge extends StatelessWidget {
  final bool isOnline;
  final double size;

  const OnlineStatusBadge({super.key, required this.isOnline, this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOnline ? AppColors.chatActive : AppColors.chatOfflineLight,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surfaceLight, width: 2),
      ),
    );
  }
}
