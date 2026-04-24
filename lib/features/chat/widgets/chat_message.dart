import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final AnimationController animationController;

  const ChatMessage({
    required this.text,
    required this.isMe,
    required this.animationController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        child: Container(child: isMe ? _sendMessage() : _receiveMessage()),
      ),
    );
  }

  Widget _sendMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8, right: 8, left: 120),
        decoration: BoxDecoration(
          color: Platform.isIOS ? AppColors.primary : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: AppTextStyle.chatMessage,
        ),
      ),
    );
  }

  Widget _receiveMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 120),
        decoration: BoxDecoration(
          color: Platform.isIOS
              ? AppColors.darkTextSecondary
              : AppColors.chatOffline,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: AppTextStyle.chatMessage,
        ),
      ),
    );
  }
}
