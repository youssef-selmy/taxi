import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'step_indicator_item_status.dart';
import 'step_indicator_item_style.dart';

export 'step_indicator_item_status.dart';
export 'step_indicator_item_style.dart';

typedef BetterStepGlygh = AppStepGlygh;

class AppStepGlygh extends StatelessWidget {
  final IconData? icon;
  final String number;
  final StepIndicatorItemStatus status;
  final StepIndicatorItemStyle style;

  const AppStepGlygh({
    super.key,
    required this.icon,
    required this.number,
    required this.status,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: _backgroundColor(context),
        border: _border(context),
      ),
      child: _content(context),
    );
  }

  BorderRadius get _borderRadius => switch (style) {
    StepIndicatorItemStyle.circular => BorderRadius.circular(100),
    StepIndicatorItemStyle.rounded => BorderRadius.circular(6),
  };

  Color _backgroundColor(BuildContext context) => switch (status) {
    StepIndicatorItemStatus.completed => context.colors.success,
    StepIndicatorItemStatus.active => context.colors.primary,
    StepIndicatorItemStatus.next => context.colors.surface,
    StepIndicatorItemStatus.upcoming => context.colors.surface,
  };

  Border? _border(BuildContext context) {
    return switch (status) {
      StepIndicatorItemStatus.next => Border.all(
        color: context.colors.outlineVariant,
      ),
      StepIndicatorItemStatus.upcoming => Border.all(
        color: context.colors.outline,
      ),
      _ => null,
    };
  }

  Widget _content(BuildContext context) {
    if (icon != null) {
      return Icon(icon!, color: _foregroundColor(context), size: 16);
    }
    return SizedBox(
      width: 16,
      height: 16,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, -0.5),
          child: Text(
            number,
            style: context.textTheme.labelMedium?.copyWith(
              color: _foregroundColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Color _foregroundColor(BuildContext context) {
    return switch (status) {
      StepIndicatorItemStatus.completed => context.colors.onSuccess,
      StepIndicatorItemStatus.active => context.colors.onPrimary,
      StepIndicatorItemStatus.next => context.colors.onSurface,
      StepIndicatorItemStatus.upcoming => context.colors.onSurfaceVariantLow,
    };
  }
}
