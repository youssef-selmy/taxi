import 'package:flutter/material.dart';

enum TooltipSize {
  small,
  medium,
  large;

  EdgeInsets get padding {
    switch (this) {
      case TooltipSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case TooltipSize.medium:
        return const EdgeInsets.all(8);
      case TooltipSize.large:
        return const EdgeInsets.all(12);
    }
  }

  BorderRadius get borderRadius {
    switch (this) {
      case TooltipSize.small:
        return BorderRadius.circular(6);
      case TooltipSize.medium:
        return BorderRadius.circular(8);
      case TooltipSize.large:
        return BorderRadius.circular(12);
    }
  }
}
