import 'package:better_design_system/atoms/buttons/bordered_toggle_button.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppBorderedToggleButton)
Widget borderedToggleButtonUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Toggle Button',
    description: 'The text displayed on the button.',
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
    description: 'Toggle the visibility of the icon.',
  );

  final isPillShaped = context.knobs.boolean(
    label: 'Is Pill Shaped',
    initialValue: true,
    description:
        'Controls the shape of the button (pill-shaped or rectangular).',
  );

  final style = context.knobs.object.dropdown<BorderedToggleButtonStyle>(
    label: 'Style',
    options: BorderedToggleButtonStyle.values,
    initialOption: BorderedToggleButtonStyle.outline,
    labelBuilder: (value) => value.name,
    description: 'Select the visual style (outline or soft).',
  );

  final prefixIcon = showIcon ? Icons.edit : null;

  return AppBorderedToggleButton(
    label: label,
    isSelected: context.knobs.isSelected,
    isDisabled: context.knobs.isDisabled,
    size: context.knobs.buttonSize,
    prefixIcon: prefixIcon,
    isPillShaped: isPillShaped,
    color: context.knobs.semanticColor,
    style: style,
    onPressed: () {},
  );
}
