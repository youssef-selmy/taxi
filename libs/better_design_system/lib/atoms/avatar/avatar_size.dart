import 'package:flutter/material.dart';

import '../status_badge/status_badge_size.dart';

/// Defines predefined sizes for the avatar.
enum AvatarSize {
  xs12px(12),
  sm14px(14),
  md16px(16),
  lg18px(18),
  xl20px(20),
  xxl24px(24),
  size32px(32),
  size40px(40),
  size48px(48),
  size56px(56),
  size64px(64),
  size72px(72),
  size80px(80),
  size96px(96),
  size128px(128);

  final double value;

  const AvatarSize(this.value);

  /// Returns the size of the status badge based on the provided avatar size.
  StatusBadgeSize get statusBadgeSize => switch (this) {
    // For small avatars, use extra small or small status badge.
    AvatarSize.xs12px => StatusBadgeSize.extraSmall,
    AvatarSize.sm14px ||
    AvatarSize.md16px ||
    AvatarSize.lg18px ||
    AvatarSize.xl20px => StatusBadgeSize.small,
    // For medium avatars, use regular small status badge.
    AvatarSize.xxl24px ||
    AvatarSize.size32px ||
    AvatarSize.size40px => StatusBadgeSize.regularSmall,
    // For larger avatars, use medium or large status badge.
    AvatarSize.size48px || AvatarSize.size56px => StatusBadgeSize.medium,
    AvatarSize.size64px ||
    AvatarSize.size72px ||
    AvatarSize.size80px ||
    AvatarSize.size96px ||
    AvatarSize.size128px => StatusBadgeSize.large,
  };

  EdgeInsets get padding => switch (this) {
    // For small avatars, return small padding.
    AvatarSize.xs12px ||
    AvatarSize.sm14px ||
    AvatarSize.md16px ||
    AvatarSize.lg18px => const EdgeInsets.all(2),
    // For medium avatars, return moderate padding.
    AvatarSize.xl20px ||
    AvatarSize.xxl24px ||
    AvatarSize.size32px => const EdgeInsets.all(3),
    // For larger avatars, return larger padding.
    AvatarSize.size40px ||
    AvatarSize.size48px ||
    AvatarSize.size56px => const EdgeInsets.all(5),
    AvatarSize.size64px => const EdgeInsets.all(6),
    AvatarSize.size72px => const EdgeInsets.all(7),
    // For extra large avatars, return even larger padding.
    AvatarSize.size80px => const EdgeInsets.all(8),
    AvatarSize.size96px => const EdgeInsets.all(10),
    AvatarSize.size128px => const EdgeInsets.all(15),
  };

  double get iconSize => switch (this) {
    // For small avatars, return small icon size.
    AvatarSize.xs12px ||
    AvatarSize.sm14px ||
    AvatarSize.md16px ||
    AvatarSize.lg18px => 10,
    // For medium avatars, return moderate icon size.
    AvatarSize.xl20px || AvatarSize.xxl24px || AvatarSize.size32px => 12,
    // For larger avatars, return larger icon size.
    AvatarSize.size40px || AvatarSize.size48px || AvatarSize.size56px => 16,
    AvatarSize.size64px => 32,
    AvatarSize.size72px => 48,
    // For extra large avatars, return even larger icon size.
    AvatarSize.size80px => 48,
    AvatarSize.size96px => 56,
    AvatarSize.size128px => 64,
  };
}

enum AvatarGroupSize {
  small,
  medium,
  large;

  /// Returns the size of the avatar based on the group size.
  AvatarSize get avatarSize => switch (this) {
    AvatarGroupSize.small => AvatarSize.xl20px,
    AvatarGroupSize.medium => AvatarSize.size32px,
    AvatarGroupSize.large => AvatarSize.size40px,
  };
}
