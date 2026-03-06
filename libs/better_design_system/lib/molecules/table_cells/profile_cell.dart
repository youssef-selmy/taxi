import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterProfileCell = AppProfileCell;

class AppProfileCell extends StatelessWidget {
  final String name;
  final String? subtitle;
  final SemanticColor? subtitleColor;
  final String? imageUrl;
  final AvatarPlaceholder avatarPlaceHolder;
  final StatusBadgeType? statusBadgeType;

  const AppProfileCell({
    super.key,
    required this.name,
    this.subtitle,
    this.subtitleColor,
    this.imageUrl,
    this.avatarPlaceHolder = AvatarPlaceholder.user,
    this.statusBadgeType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(
          imageUrl: imageUrl,
          placeholder: avatarPlaceHolder,
          size: AvatarSize.size40px,
          statusBadgeType: statusBadgeType ?? StatusBadgeType.none,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Text(
                name,
                style: context.textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: context.textTheme.bodySmall?.apply(
                    color: subtitleTextColor(context),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color? subtitleTextColor(BuildContext context) {
    if (subtitleColor != null) {
      return subtitleColor!.main(context);
    }
    return context.colors.onSurfaceVariantLow;
  }
}
