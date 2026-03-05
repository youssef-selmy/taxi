import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class DriverProfileSmall extends StatelessWidget {
  final String? imageUrl;
  final String? fullName;

  const DriverProfileSmall({
    super.key,
    required this.imageUrl,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(imageUrl: imageUrl),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.driver,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            Text(fullName ?? "", style: context.textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
