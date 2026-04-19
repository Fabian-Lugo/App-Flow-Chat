import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flow_chat/theme/app_assets.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Platform.isIOS
            ? Image.asset(AppAssets.foreground, width: 200)
            : Image.asset(AppAssets.foreground, width: 260),
      ],
    );
  }
}
