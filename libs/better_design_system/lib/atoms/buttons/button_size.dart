import 'package:flutter/material.dart';

import 'package:better_design_system/utils/extensions/extensions.dart';

enum ButtonSize {
  small,
  medium,
  large,
  extraLarge;

  BorderRadius get borderRadius {
    switch (this) {
      case ButtonSize.small:
        return BorderRadius.circular(6);
      case ButtonSize.medium:
        return BorderRadius.circular(8);
      case ButtonSize.large:
        return BorderRadius.circular(8);
      case ButtonSize.extraLarge:
        return BorderRadius.circular(10);
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 4, vertical: 4);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
      case ButtonSize.extraLarge:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }

  double get iconSize {
    switch (this) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 20;
      case ButtonSize.extraLarge:
        return 24;
    }
  }

  TextStyle? textStyle(BuildContext context) {
    switch (this) {
      case ButtonSize.small:
        return context.textTheme.labelMedium;
      case ButtonSize.medium:
        return context.textTheme.labelLarge;
      case ButtonSize.large:
        return context.textTheme.labelLarge;
      case ButtonSize.extraLarge:
        return context.textTheme.bodyLarge;
    }
  }
}
