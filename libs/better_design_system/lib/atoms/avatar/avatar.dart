import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:better_design_system/atoms/status_badge/status_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

import '../status_badge/status_badge_type.dart';

import 'avatar_placeholder.dart';
import 'avatar_size.dart';
import 'avatar_style.dart';

export 'avatar_size.dart';
export 'avatar_style.dart';
export '../status_badge/status_badge_type.dart';
export 'avatar_placeholder.dart';

typedef BetterAvatar = AppAvatar;

class AppAvatar extends StatelessWidget {
  /// The shape of the avatar (e.g., rounded, square, circle).
  final AvatarShape shape;

  /// The size of the avatar.
  final AvatarSize size;

  /// The placeholder type to display when the image is not available.
  /// Defaults to [AvatarPlaceholder.user].
  /// This is used when the image URL is null.
  final AvatarPlaceholder placeholder;

  /// The status badge type to display (e.g., online, offline, etc.).
  final StatusBadgeType statusBadgeType;

  final String? imageUrl;

  /// Whether or not to enable a border around the avatar.
  final bool enabledBorder;

  const AppAvatar({
    super.key,
    this.shape = AvatarShape.circle,
    this.size = AvatarSize.xl20px,
    this.placeholder = AvatarPlaceholder.user,
    this.statusBadgeType = StatusBadgeType.none,
    this.enabledBorder = false,

    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Container(
          width: size.value,
          height: size.value,
          decoration: BoxDecoration(
            borderRadius: shape == AvatarShape.circle
                ? BorderRadius.circular(1000)
                : shape.borderRadius(size),
            border: enabledBorder
                ? Border.all(color: context.colors.surfaceVariant, width: 1.5)
                : null,
          ),
          child: ClipRRect(
            borderRadius: shape == AvatarShape.circle
                ? BorderRadius.circular(1000)
                : shape.borderRadius(size),
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    errorWidget: (context, url, error) =>
                        _placeholder(context, size),
                  )
                : _placeholder(context, size),
          ),
        ),
        if (statusBadgeType != StatusBadgeType.none)
          Positioned(
            right: -4,
            top: shape != AvatarShape.circle ? -4 : null,
            bottom: shape == AvatarShape.circle ? -4 : null,
            child: Padding(
              padding: shape == AvatarShape.circle
                  ? size.padding
                  : EdgeInsets.zero,
              child: Container(
                width: size.statusBadgeSize.value + 3,
                height: size.statusBadgeSize.value + 3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.surface,
                ),
                child: Center(
                  child: AppStatusBadge(
                    statusBadgeType: statusBadgeType,
                    statusBadgeSize: size.statusBadgeSize,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Container _placeholder(BuildContext context, AvatarSize avatarSize) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceVariantLow,
        borderRadius: shape.borderRadius(avatarSize),
      ),
      child: Icon(
        placeholder.icon,
        color: context.colors.onSurfaceVariant,
        size: avatarSize.iconSize,
      ),
    );
  }
}
