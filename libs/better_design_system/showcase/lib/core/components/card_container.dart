import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppCardContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;

  const AppCardContainer({
    super.key,
    required this.child,
    this.width,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
        boxShadow: [BetterShadow.shadowCard.toBoxShadow(context)],
      ),
      child: child,
    );
  }
}
