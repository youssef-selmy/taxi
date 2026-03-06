import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum TitleSize { small, medium, large }

extension TitleSizeExtension on TitleSize {
  TextStyle style(BuildContext context) {
    switch (this) {
      case TitleSize.small:
        return context.textTheme.bodyLarge!;

      case TitleSize.medium:
        throw UnimplementedError();

      case TitleSize.large:
        return context.textTheme.headlineLarge!;
    }
  }

  TextStyle subTitleStyle(BuildContext context) {
    switch (this) {
      case TitleSize.small:
        return context.textTheme.bodyMedium!.variant(context);

      case TitleSize.medium:
        throw UnimplementedError();

      case TitleSize.large:
        return context.textTheme.bodyLarge!.variant(context);
    }
  }
}
