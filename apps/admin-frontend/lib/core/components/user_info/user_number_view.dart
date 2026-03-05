import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class UserNumberView extends StatelessWidget {
  final String number;

  const UserNumberView({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(BetterIcons.call02Filled, color: context.colors.primary, size: 16),
        const SizedBox(width: 4),
        Text(
          number,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.onSurface,
            letterSpacing: 0.15,
          ),
        ),
      ],
    );
  }
}
