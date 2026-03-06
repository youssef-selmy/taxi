import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterDesktopTopBar = AppDesktopTopBar;

class AppDesktopTopBar extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AppDesktopTopBar({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title, style: context.textTheme.titleMedium),
        if (subtitle != null)
          Text(
            subtitle!,
            style: context.textTheme.bodyMedium?.variant(context),
          ),
      ],
    );
  }
}
