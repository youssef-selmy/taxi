import 'package:flutter/material.dart';

enum FabSize {
  small,
  medium,
  large,
  extraLarge;

  EdgeInsets padding({required bool hasText}) {
    if (!hasText) {
      switch (this) {
        case FabSize.small:
          return const EdgeInsets.all(10);
        case FabSize.medium:
          return const EdgeInsets.all(12);
        case FabSize.large:
          return const EdgeInsets.all(16);
        case FabSize.extraLarge:
          return const EdgeInsets.all(20);
      }
    }
    switch (this) {
      case FabSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
      case FabSize.medium:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
      case FabSize.large:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 16);
      case FabSize.extraLarge:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 20);
    }
  }

  double iconSize({required bool hasText}) {
    if (hasText) return 16;
    switch (this) {
      case FabSize.small:
        return 20;
      case FabSize.medium:
        return 24;
      case FabSize.large:
        return 24;
      case FabSize.extraLarge:
        return 28;
    }
  }
}
