import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class DriverProfileMedium extends StatelessWidget {
  final String? imageUrl;
  final String? fullName;
  final int? rating;

  const DriverProfileMedium({
    super.key,
    required this.imageUrl,
    required this.fullName,
    required this.rating,
  });

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
              fullName ?? context.tr.unknown,
              style: context.textTheme.labelMedium,
            ),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: context.colors.warning),
                const SizedBox(width: 4),
                Text(
                  rating?.toString() ?? "0",
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
