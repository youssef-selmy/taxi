import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter/cupertino.dart';

/// Defines the available shapes for the avatar widget.
/// - `square`: A perfect square with sharp edges.
/// - `rounded`: A square with slightly rounded corners.
/// - `circle`: A fully circular avatar.
enum AvatarShape {
  square,
  rounded,
  circle;

  /// Returns the border radius based on the selected avatar shape.
  // ignore: unused_field
  BorderRadius borderRadius(AvatarSize size) {
    switch (this) {
      case AvatarShape.square:
        return BorderRadius.zero;
      case AvatarShape.rounded:
        return BorderRadius.circular(_getBorderRadiusSize(size));
      case AvatarShape.circle:
        return BorderRadius.zero;
    }
  }

  double _getBorderRadiusSize(AvatarSize avatarSize) {
    switch (avatarSize) {
      // For small avatars, return a smaller border radius.
      case AvatarSize.xs12px:
      case AvatarSize.sm14px:
      case AvatarSize.md16px:
      case AvatarSize.lg18px:
        return 2;
      // For medium to large avatars, return a larger border radius.
      case AvatarSize.xl20px:
      case AvatarSize.xxl24px:
      case AvatarSize.size32px:
        return 4;
      case AvatarSize.size40px:
        return 6;
      case AvatarSize.size48px:
      case AvatarSize.size56px:
        return 8;
      case AvatarSize.size64px:
      case AvatarSize.size72px:
        return 10;
      // For extra large avatars, return an even larger border radius.
      case AvatarSize.size80px:
      case AvatarSize.size96px:
      case AvatarSize.size128px:
        return 12;
    }
  }
}
