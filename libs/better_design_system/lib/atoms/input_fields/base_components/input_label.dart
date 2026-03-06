import 'package:better_design_system/molecules/tooltip/tooltip.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

typedef BetterInputLabel = AppInputLabel;

class AppInputLabel extends StatelessWidget {
  final String label;
  final String? sublabel;
  final bool isRequired;
  final bool isDisabled;
  final String? helpText;

  const AppInputLabel({
    super.key,
    required this.label,
    this.sublabel,
    this.isDisabled = false,
    this.isRequired = false,
    this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 2,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.apply(
            color: isDisabled
                ? context.colors.onSurfaceDisabled
                : context.colors.onSurface,
          ),
        ),
        if (isRequired)
          Text(
            '*',
            style: context.textTheme.labelLarge?.apply(
              color: isDisabled
                  ? context.colors.onSurfaceDisabled
                  : context.colors.primary,
            ),
          ),
        if (sublabel != null) ...[
          const SizedBox(width: 4),
          Text(
            sublabel!,
            style: context.textTheme.bodySmall?.apply(
              color: isDisabled
                  ? context.colors.onSurfaceDisabled
                  : context.colors.onSurfaceVariantLow,
            ),
          ),
        ],
        if (helpText != null) ...[
          AppTooltip(
            title: helpText!,
            trigger: isDisabled ? TooltipTrigger.none : TooltipTrigger.hover,
            alignment: TooltipAlignment.top,
            child: Icon(
              BetterIcons.alertCircleFilled,
              size: 12,
              color: isDisabled
                  ? context.colors.onSurfaceMuted
                  : context.colors.onSurfaceVariantLow,
            ),
          ),
        ],
      ],
    );
  }
}
