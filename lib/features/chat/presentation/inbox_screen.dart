import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/services/socket.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/router/app_routes.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/features/auth/services/auth.dart';
import 'package:flow_chat/features/chat/services/user.dart';
import 'package:flow_chat/features/chat/widgets/gradient_text.dart';
import 'package:flow_chat/features/chat/widgets/connection_styles.dart';
import 'package:flow_chat/features/chat/widgets/user_avatar_style.dart';
import 'package:flow_chat/features/chat/widgets/online_status_badge.dart';

String _truncateNameForSlider(String name) {
  const int maxChars = 10;
  if (name.length <= maxChars) return name;
  return '${name.substring(0, maxChars)}...';
}

String _nameWithYouLabel(UserModel user, String? currentUserUid) {
  if (currentUserUid == null) return user.name;
  if (user.uid == currentUserUid) return '${user.name} (Tú)';
  return user.name;
}

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  SocketService? _socketService;
  ServerStatus? _lastSocketStatus;
  void goChat(UserModel user) {
    context.push(AppRoutes.nestedChat, extra: user);
  }

  void _onRefreshUsers({bool fromPullRefresh = false}) async {
    final newUsers = await UserService().getUsers();
    if (!mounted) return;
    setState(() {
      users = newUsers;
    });
    if (fromPullRefresh) {
      _refreshController.refreshCompleted();
    }
  }

  void _onSocketServiceChanged() {
    if (!mounted) return;
    final service = _socketService;
    if (service == null) return;
    final now = service.serverStatus;
    final wasOnline = _lastSocketStatus == ServerStatus.online;
    if (!wasOnline && now == ServerStatus.online) {
      _onRefreshUsers();
    }
    _lastSocketStatus = now;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _onRefreshUsers();
      _socketService = Provider.of<SocketService>(context, listen: false);
      _lastSocketStatus = _socketService!.serverStatus;
      _socketService!.addListener(_onSocketServiceChanged);
    });
  }

  @override
  void dispose() {
    _socketService?.removeListener(_onSocketServiceChanged);
    _refreshController.dispose();
    super.dispose();
  }

  List<UserModel> users = [];

  final List<Color> colors = [
    AppColors.primaryDark.withOpacity(0.8),
    AppColors.primaryLight,
  ];

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final currentUserUid = Provider.of<AuthService>(context).user?.uid;
    final onlineUsers = users.where((u) => u.online).toList();
    return Scaffold(
      appBar: AppBar(
        title: _InboxAppBarContent(colors: colors),
        toolbarHeight: 70,
        backgroundColor: AppColors.surfaceLight,
        elevation: 3,
      ),
      body: _MainScrollBody(
        refreshController: _refreshController,
        onRefresh: () => _onRefreshUsers(fromPullRefresh: true),
        socketService: socketService,
        onlineUsers: onlineUsers,
        users: users,
        currentUserUid: currentUserUid,
        onTap: goChat,
      ),
    );
  }
}

class _InboxAppBarContent extends StatelessWidget {
  final List<Color> colors;

  const _InboxAppBarContent({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GradientText(
              text: 'Flow Chat',
              style: AppTextStyle.appBarTitle,
              colors: colors,
            ),
          ),
          IconButton(
            onPressed: () => context.push(AppRoutes.nestedProfile),
            icon: Icon(CupertinoIcons.person, size: 30),
          ),
        ],
      ),
    );
  }
}

class _MainScrollBody extends StatelessWidget {
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final SocketService socketService;
  final List<UserModel> users;
  final List<UserModel> onlineUsers;
  final String? currentUserUid;
  final Function onTap;

  const _MainScrollBody({
    required this.refreshController,
    required this.onRefresh,
    required this.socketService,
    required this.users,
    required this.onlineUsers,
    required this.currentUserUid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      onRefresh: onRefresh,
      header: ClassicHeader(
        completeIcon: Icon(Icons.check, color: AppColors.accent),
      ),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          ConnectionStyles(
            state: socketService.serverStatus == ServerStatus.connecting
                ? ConnectionStateStyle.connecting
                : socketService.serverStatus == ServerStatus.online
                ? ConnectionStateStyle.connected
                : ConnectionStateStyle.disconnected,
          ),
          Align(
            alignment: AlignmentGeometry.center,
            child: Text('Amigos conectados', style: AppTextStyle.bodySmall),
          ),
          _ActiveFriendsSlider(
            onlineUsers: onlineUsers,
            currentUserUid: currentUserUid,
            onTap: onTap,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Align(
              alignment: AlignmentGeometry.centerStart,
              child: Text(
                'Bandeja de entrada',
                style: AppTextStyle.headingSmall,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (_, i) => _ChatUserTile(
              user: users[i],
              currentUserUid: currentUserUid,
              onTap: onTap,
            ),
            separatorBuilder: (_, i) => Divider(),
          ),
        ],
      ),
    );
  }
}

class _ChatUserTile extends StatelessWidget {
  final UserModel user;
  final String? currentUserUid;
  final Function onTap;

  const _ChatUserTile({
    required this.user,
    required this.currentUserUid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _nameWithYouLabel(user, currentUserUid),
        style: AppTextStyle.labelBold,
      ),
      subtitle: Text(user.email, style: AppTextStyle.bodySmall),
      leading: UserAvatarStyle(
        user: user,
        radius: 25,
        showBadge: false,
        useAccentGradient: true,
        profileStyle: false,
        profileInitials: false,
      ),
      trailing: OnlineStatusBadge(isOnline: user.online, size: 12),
      onTap: () => onTap(user),
    );
  }
}

class _ActiveFriendsSlider extends StatelessWidget {
  final List<UserModel> onlineUsers;
  final String? currentUserUid;
  final Function onTap;

  const _ActiveFriendsSlider({
    required this.onlineUsers,
    required this.currentUserUid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final otherOnlineUsers = currentUserUid == null
        ? onlineUsers
        : onlineUsers.where((u) => u.uid != currentUserUid).toList();
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemCount: otherOnlineUsers.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_, i) {
          final user = otherOnlineUsers[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => onTap(user),
                  behavior: HitTestBehavior.opaque,
                  child: UserAvatarStyle(
                    user: user,
                    radius: 35,
                    showBadge: true,
                    useAccentGradient: false,
                    profileStyle: false,
                    profileInitials: false,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 80,
                  height: 22,
                  child: Text(
                    _truncateNameForSlider(
                      _nameWithYouLabel(user, currentUserUid),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: AppTextStyle.labelBold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
