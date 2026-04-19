import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/features/chat/widgets/online_status_badge.dart';

class UserAvatarStyle extends StatelessWidget {
  final UserModel user;
  final double radius;
  final bool showBadge;
  final bool useAccentGradient;
  final bool profileStyle;
  final bool profileInitials;

  const UserAvatarStyle({
    super.key,
    required this.user,
    required this.radius,
    required this.showBadge,
    required this.useAccentGradient,
    required this.profileStyle,
    required this.profileInitials,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: profileStyle
                  ? [AppColors.primary, AppColors.primaryDark.withOpacity(0.6)]
                  : Platform.isIOS
                  ? useAccentGradient
                        ? [
                            AppColors.accentLight,
                            AppColors.chatActiveDark.withOpacity(0.7),
                          ]
                        : [AppColors.text, AppColors.text.withOpacity(0.5)]
                  : useAccentGradient
                  ? [
                      AppColors.accentLight,
                      AppColors.accentDark.withOpacity(0.6),
                    ]
                  : [AppColors.text, AppColors.text.withOpacity(0.6)],
            ),
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            child: Text(
              user.name.substring(0, 2),
              style: profileInitials
                  ? AppTextStyle.profileInitials
                  : AppTextStyle.avatarInitials,
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            right: 1,
            bottom: 1,
            child: OnlineStatusBadge(isOnline: user.online, size: 20),
          ),
      ],
    );
  }
}
