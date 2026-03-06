import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// A reusable card container widget for HR Platform components.
///
/// Provides consistent styling with surface color, rounded corners, border,
/// and shadow across all HR Platform card components.
class HrPlatformCardContainer extends StatelessWidget {
  /// The child widget to display inside the card.
  final Widget child;

  /// Optional custom padding. Defaults to 16 on all sides.
  final EdgeInsets? padding;

  /// Optional custom height constraint.
  final double? height;

  const HrPlatformCardContainer({
    super.key,
    required this.child,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
        boxShadow: [BetterShadow.shadow16.toBoxShadow(context)],
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}
