import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class NotificationPanelTabItem extends StatelessWidget {
  final String title;
  final int count;

  const NotificationPanelTabItem({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: context.textTheme.labelMedium),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            count.toString(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
