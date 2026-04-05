import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/theme/app_colors.dart';
import 'package:flow_chat/theme/app_routes.dart';
import 'package:flow_chat/theme/app_text_style.dart';
import 'package:flow_chat/widgets/connection_styles.dart';
import 'package:flow_chat/widgets/gradient_text.dart';
import 'package:flow_chat/widgets/online_status_badge.dart';
import 'package:flow_chat/widgets/user_avatar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final List<User> users = [
    User(uid: '1', name: 'Fabian', email: 'fabian@flow.com', online: true),
    User(uid: '2', name: 'Alonso', email: 'alonso@test.com', online: false),
    User(uid: '3', name: 'Lugo', email: 'lugo@dev.com', online: true),
    User(uid: '4', name: 'Alejandra', email: 'ale@flow.com', online: true),
    User(uid: '1', name: 'Fabian', email: 'fabian@flow.com', online: true),
    User(uid: '2', name: 'Alonso', email: 'alonso@test.com', online: false),
    User(uid: '3', name: 'Lugo', email: 'lugo@dev.com', online: true),
    User(uid: '4', name: 'Alejandra', email: 'ale@flow.com', online: true),
    User(uid: '1', name: 'Fabian', email: 'fabian@flow.com', online: true),
    User(uid: '2', name: 'Alonso', email: 'alonso@test.com', online: false),
    User(uid: '3', name: 'Lugo', email: 'lugo@dev.com', online: true),
    User(uid: '4', name: 'Alejandra', email: 'ale@flow.com', online: true),
  ];

  final List<Color> colors = [
    AppColors.primaryDark.withOpacity(0.8),
    AppColors.primaryLight,
  ];

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void goChat(User user) {
    Navigator.pushNamed(context, AppRoutes.chat, arguments: user);
  }

  void _onRefreshUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        onRefresh: _onRefreshUsers,
        onlineUsers: onlineUsers,
        users: users,
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
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
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
  final List<User> users;
  final List<User> onlineUsers;
  final Function onTap;

  const _MainScrollBody({
    required this.refreshController,
    required this.onRefresh,
    required this.users,
    required this.onlineUsers,
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
          ConnectionStyles(state: ConnectionStateStyle.connected),
          Align(
            alignment: AlignmentGeometry.center,
            child: Text('Amigos conectados', style: AppTextStyle.bodySmall),
          ),
          _ActiveFriendsSlider(onlineUsers: onlineUsers, onTap: onTap),
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
            itemBuilder: (_, i) => _ChatUserTile(user: users[i], onTap: onTap),
            separatorBuilder: (_, i) => Divider(),
          ),
        ],
      ),
    );
  }
}

class _ChatUserTile extends StatelessWidget {
  final User user;
  final Function onTap;

  const _ChatUserTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name, style: AppTextStyle.labelBold),
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
  final List<User> onlineUsers;
  final Function onTap;

  const _ActiveFriendsSlider({required this.onlineUsers, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: onlineUsers.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_, i) {
          final user = onlineUsers[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
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
                  width: 70,
                  child: Text(
                    user.name,
                    textAlign: TextAlign.center,
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
