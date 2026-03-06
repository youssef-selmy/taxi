import 'package:better_design_system/atoms/avatar/avatar_size.dart';
import 'package:flutter/material.dart';

enum BadgeSize {
  small,
  medium,
  large;

  /// Returns the padding based on the badge size
  EdgeInsets padding(bool isRounded) => switch (this) {
    BadgeSize.small => const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    BadgeSize.medium => EdgeInsets.symmetric(
      horizontal: isRounded ? 6 : 4,
      vertical: 4,
    ),
    BadgeSize.large => EdgeInsets.symmetric(
      horizontal: isRounded ? 8 : 4,
      vertical: 4,
    ),
  };

  AvatarSize get avatarSize => switch (this) {
    BadgeSize.small => AvatarSize.xs12px,
    BadgeSize.medium => AvatarSize.xs12px,
    BadgeSize.large => AvatarSize.md16px,
  };
}
