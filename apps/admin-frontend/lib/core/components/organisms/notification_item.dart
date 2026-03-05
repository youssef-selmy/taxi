import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

typedef UserInformation = ({String firstName, String lastName, String email});

class NotificationItem extends StatelessWidget {
  final IconData? icon;
  final String? imageUrl;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? readAt;
  final UserInformation? userInformation;

  const NotificationItem({
    super.key,
    this.icon,
    this.imageUrl,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.readAt,
    this.userInformation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        if (icon != null)
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryContainer,
            ),
            child: Icon(icon, size: 22, color: context.colors.primary),
          ),
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(title, style: context.textTheme.bodyMedium),
              Text(
                createdAt.formatDateTime,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.surfaceVariantLow,
                ),
              ),
              Text(
                description,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        ),
        Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (readAt == null)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.primary,
                ),
              ),
            Text(
              createdAt.toTimeAgo,
              style: context.textTheme.labelMedium?.variantLow(context),
            ),
          ],
        ),
      ],
    );
  }
}
