import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'divider_text_alignment.dart';

export 'divider_text_alignment.dart';

typedef BetterDivider = AppDivider;

class AppDivider extends StatelessWidget {
  final String? text;
  final DividerTextAlignment alignment;
  final bool isDashed;
  final double height;

  const AppDivider({
    super.key,
    this.text,
    this.alignment = DividerTextAlignment.center,
    this.isDashed = false,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final dividerLine = isDashed
        ? _buildDashedDivider(context)
        : Container(height: 1, color: context.colors.outline);

    if (text != null) {
      return Row(
        spacing: 16,
        children: [
          if (alignment != DividerTextAlignment.left)
            Expanded(child: dividerLine),
          Text(text!, style: _textStyle(context)),
          if (alignment != DividerTextAlignment.right)
            Expanded(child: dividerLine),
        ],
      );
    }

    return SizedBox(
      height: height,
      child: Center(child: dividerLine),
    );
  }

  TextStyle? _textStyle(BuildContext context) {
    return context.textTheme.labelMedium;
  }

  LayoutBuilder _buildDashedDivider(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.maxWidth;
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        const dashSpace = 2.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.colors.outline),
              ),
            );
          }),
        );
      },
    );
  }
}
