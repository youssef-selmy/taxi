import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showBackButton = false,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: 8,
                children: [
                  if (showBackButton || onBackButtonPressed != null) ...[
                    AppIconButton(
                      onPressed:
                          onBackButtonPressed ??
                          () {
                            context.router.back();
                          },
                      icon: BetterIcons.arrowLeft02Outline,
                    ),
                  ],
                  Text(title, style: context.textTheme.headlineSmall),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
              ],
            ],
          ),
        ),
        if (actions != null)
          ...actions!.map(
            (e) => Padding(padding: const EdgeInsets.only(left: 8), child: e),
          ),
      ],
    );
  }
}
