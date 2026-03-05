import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class CustomerProfileSmall extends StatelessWidget {
  final String? imageUrl;
  final String? fullName;

  const CustomerProfileSmall({super.key, this.imageUrl, this.fullName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(imageUrl: imageUrl, size: AvatarSize.size48px),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.customer,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            Text(fullName ?? "", style: context.textTheme.labelLarge),
          ],
        ),
      ],
    );
  }
}
