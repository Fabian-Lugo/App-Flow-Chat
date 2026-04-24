import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/models/message.dart';
import 'package:flow_chat/services/socket.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/utils/input_styles_border.dart';
import 'package:flow_chat/features/auth/services/auth.dart';
import 'package:flow_chat/features/chat/services/messages.dart';
import 'package:flow_chat/features/chat/widgets/user_avatar_style.dart';
import 'package:flow_chat/features/chat/widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? user;
  const ChatScreen({this.user, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controllerText = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final SocketService socketService;
  late final AuthService authService;
  late final MessagesService messagesService;
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    messagesService = Provider.of<MessagesService>(context, listen: false);
    socketService.socket?.on('message', _listenToMessages);
    _loadMessages(widget.user!.uid);
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket?.off('message');
    super.dispose();
  }

  void _loadMessages(String userId) async {
    final List<MessageModel> messages = await messagesService.getMessagesByUser(
      userId,
    );
    final List<ChatMessage> historyMessages = messages
        .map(
          (message) => ChatMessage(
            text: message.message,
            isMe: message.sender == authService.user?.uid,
            animationController: AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 400),
            ),
          ),
        )
        .toList();

    if (!mounted) return;

    setState(() {
      _messages.addAll(historyMessages);
    });

    for (final ChatMessage m in historyMessages) {
      m.animationController.forward();
    }
  }

  void _listenToMessages(dynamic payload) {
    ChatMessage message = ChatMessage(
      text: payload['text'],
      isMe: payload['sender'] == authService.user!.uid,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );

    setState(() {
      _messages.insert(0, message);
      message.animationController.forward();
    });
  }

  void _handleNewMessage(String text) {
    final newMessage = ChatMessage(
      text: text,
      isMe: true,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    setState(() {
      _messages.insert(0, newMessage);
      newMessage.animationController.forward();
    });
    socketService.socket?.emit('message', {
      'text': text,
      'sender': authService.user?.uid,
      'receiver': widget.user?.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUserUid = context.watch<AuthService>().user?.uid;
    final UserModel? contact = widget.user;
    String titleName = contact?.name ?? 'Usuario';
    if (currentUserUid != null &&
        contact != null &&
        contact.uid == currentUserUid) {
      titleName = '$titleName (Tú)';
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: _ChatAppbarContent(user: widget.user, name: titleName),
        elevation: 1,
        leading: IconButton(
          onPressed: () => context.pop(),
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
  final UserModel? user;
  final String name;
  const _ChatAppbarContent({required this.user, required this.name});

  @override
  State<_ChatAppbarContent> createState() => _ChatAppbarContentState();
}

class _ChatAppbarContentState extends State<_ChatAppbarContent> {
  static const int _maxNameLengthForNormalTitleSize = 15;

  @override
  Widget build(BuildContext context) {
    final bool useCompactTitle =
        widget.name.length > _maxNameLengthForNormalTitleSize;
    final TextStyle titleStyle = useCompactTitle
        ? AppTextStyle.chatAppBarContactNameCompact
        : AppTextStyle.chatAppBarContactName;

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
        Expanded(
          child: Text(
            widget.name,
            style: titleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
