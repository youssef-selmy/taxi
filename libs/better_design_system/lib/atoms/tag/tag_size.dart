import 'package:better_design_system/atoms/avatar/avatar_size.dart';
import 'package:flutter/material.dart';

enum TagSize {
  small,
  medium;

  /// Returns the padding based on the badge size
  EdgeInsets get padding {
    switch (this) {
      case TagSize.small:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 4);
      case TagSize.medium:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 6);
    }
  }

  AvatarSize get avatarSize {
    switch (this) {
      case TagSize.small:
        return AvatarSize.lg18px;
      case TagSize.medium:
        return AvatarSize.md16px;
    }
  }
}
