import 'dart:io';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/utils/input_styles_border.dart';
import 'package:flow_chat/widgets/chat_message.dart';
import 'package:flow_chat/widgets/user_avatar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String? userName;
  const ChatScreen({this.userName, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controllerText = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  void _handleNewMessage(String text) {
    final newMessage = ChatMessage(
      text: text,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    setState(() {
      _messages.insert(0, newMessage);
      newMessage.animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
    final String name = user?.name ?? widget.userName ?? 'Usuario';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: _ChatAppbarContent(user: user, name: name),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.chevron_left),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            ),
          ),
          Divider(),
          ChatBottomActionBuilder(
            controller: _controllerText,
            focus: _focusNode,
            onSend: _handleNewMessage,
          ),
        ],
      ),
    );
  }
}

class _ChatAppbarContent extends StatefulWidget {
  final User? user;
  final String name;
  const _ChatAppbarContent({required this.user, required this.name});

  @override
  State<_ChatAppbarContent> createState() => _ChatAppbarContentState();
}

class _ChatAppbarContentState extends State<_ChatAppbarContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.user != null)
          UserAvatarStyle(
            user: widget.user!,
            radius: 22,
            showBadge: false,
            useAccentGradient: true,
            profileStyle: true,
            profileInitials: false,
          ),
        const SizedBox(width: 12),
        Text(widget.name, style: AppTextStyle.headingSmall),
      ],
    );
  }
}

class ChatBottomActionBuilder extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final Function(String) onSend;

  const ChatBottomActionBuilder({
    required this.controller,
    required this.focus,
    required this.onSend,
    super.key,
  });

  @override
  State<ChatBottomActionBuilder> createState() =>
      _ChatBottomActionBuilderState();
}

class _ChatBottomActionBuilderState extends State<ChatBottomActionBuilder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Row(
          children: [
            ChatInputField(
              controller: widget.controller,
              focus: widget.focus,
              onSend: widget.onSend,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final Function(String) onSend;

  const ChatInputField({
    required this.controller,
    required this.focus,
    required this.onSend,
    super.key,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: widget.controller,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Mensaje...',
          hintStyle: AppTextStyle.chatInputHint,
          labelStyle: AppTextStyle.chatInputLabel,
          enabledBorder: InputStylesBorder.customBorder(
            color: AppColors.chatOffline,
          ),
          focusedBorder: InputStylesBorder.customBorder(
            color: AppColors.chatOfflineLight,
          ),
          prefixIcon: widget.controller.text.isEmpty
              ? Icon(
                  Icons.message_outlined,
                  color: AppColors.chatOffline,
                  size: 20,
                )
              : Icon(
                  Icons.message_rounded,
                  color: AppColors.accentLight,
                  size: 20,
                ),
          suffixIcon: ChatSubmitAction(
            controller: widget.controller,
            onSend: widget.onSend,
            focus: widget.focus,
          ),
        ),
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 4,
        focusNode: widget.focus,
      ),
    );
  }
}

class ChatSubmitAction extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final FocusNode focus;

  const ChatSubmitAction({
    required this.controller,
    required this.onSend,
    required this.focus,
    super.key,
  });

  void _handleSubmit(String text) {
    onSend(text);
    focus.requestFocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTextEmpty = controller.text.trim().isEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Platform.isIOS
          ? CupertinoButton(
              onPressed: isTextEmpty
                  ? null
                  : () => _handleSubmit(controller.text),
              child: isTextEmpty
                  ? Icon(
                      Icons.add_circle_outline,
                      color: AppColors.chatOffline,
                      size: 21,
                    )
                  : Text('Enviar', style: AppTextStyle.chatSendButton),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: isTextEmpty
                    ? Icon(
                        Icons.add_circle_outline,
                        color: AppColors.chatOffline,
                        size: 25,
                      )
                    : Icon(
                        CupertinoIcons.paperplane,
                        color: AppColors.primaryDark,
                        size: 25,
                      ),
                onPressed: isTextEmpty
                    ? null
                    : () => _handleSubmit(controller.text),
              ),
            ),
    );
  }
}
