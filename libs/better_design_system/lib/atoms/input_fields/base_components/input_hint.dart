import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

typedef BetterInputHint = AppInputHint;

class AppInputHint extends StatelessWidget {
  final String text;
  final SemanticColor color;

  const AppInputHint({
    super.key,
    required this.text,
    this.color = SemanticColor.neutral,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(BetterIcons.alertCircleFilled, color: _color(context), size: 12),
        Text(
          text,
          style: context.textTheme.labelMedium?.apply(color: _color(context)),
        ),
      ],
    );
  }

  Color _color(BuildContext context) {
    if (color == SemanticColor.neutral) {
      return context.colors.onSurfaceVariantLow;
    }
    return color.main(context);
  }
}
