import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppIconButton)
Widget iconButtonUseCase(BuildContext context) {
  final iconOptions = {
    'Tick Outline': BetterIcons.tick02Outline,
    'Tick Filled': BetterIcons.tick02Filled,
    'Checkmark Circle Outline': BetterIcons.checkmarkCircle02Outline,
  };

  final icon = context.knobs.object.dropdown<IconData>(
    label: 'Icon (Outline/Regular)',
    options: iconOptions.values.toList(),
    initialOption: BetterIcons.tick02Outline,
    labelBuilder: (value) {
      return iconOptions.entries
          .firstWhere(
            (entry) => entry.value == value,
            orElse: () => const MapEntry('Unknown', Icons.help),
          )
          .key;
    },
    description: 'Select the regular (outline) icon to display on the button.',
  );

  final iconSelectedOptions = {
    'Tick Filled': BetterIcons.tick02Filled,
    'Checkmark Circle Filled': BetterIcons.checkmarkCircle02Filled,
    'Settings': Icons.settings,
    'Add': Icons.add,
  };

  final iconSelected = context.knobs.object.dropdown<IconData?>(
    label: 'Icon (Selected/Filled)',
    options: [null, ...iconSelectedOptions.values],
    initialOption: Icons.settings,
    labelBuilder: (value) {
      if (value == null) return 'None (use outline icon)';
      return iconSelectedOptions.entries
          .firstWhere(
            (entry) => entry.value == value,
            orElse: () => MapEntry(value.toString(), value),
          )
          .key;
    },
    description:
        'Optional: Icon to use in selected state (e.g., filled version). If not set, uses the regular icon.',
  );

  final color = context.knobs.object.dropdown<SemanticColor>(
    label: 'Semantic Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.primary,
    labelBuilder: (value) => value.name,
    description: 'Defines the base color scheme.',
  );

  final size = context.knobs.object.dropdown<ButtonSize>(
    label: 'Button Size',
    options: ButtonSize.values,
    initialOption: ButtonSize.medium,
    labelBuilder: (value) => value.name,
    description: 'Select the size of the button.',
  );

  final style = context.knobs.object.dropdown<IconButtonStyle>(
    label: 'Icon Button Style',
    options: IconButtonStyle.values,
    initialOption: IconButtonStyle.outline,
    labelBuilder: (value) => value.name,
    description: 'Select the style (outline or ghost).',
  );

  final isCircular = context.knobs.boolean(
    label: 'Is Circular',
    initialValue: false,
    description: 'Controls if the button has a circular shape.',
  );

  final isSelected = context.knobs.boolean(
    label: 'Is Selected',
    initialValue: false,
    description: 'Controls the selected state of the button.',
  );

  final isDisabled = context.knobs.boolean(
    label: 'Is Disabled',
    initialValue: false,
    description: 'Controls the enabled/disabled state of the button.',
  );

  final iconColor = context.knobs.colorOrNull(
    label: 'Icon Color (Optional)',
    initialValue: null,
    description:
        'Overrides the default icon color. If null, semantic coloring applies.',
  );

  final iconSize = context.knobs.doubleOrNull.slider(
    label: 'Icon Size (Optional)',
    initialValue: switch (size) {
      ButtonSize.small => 16,
      ButtonSize.medium => 20,
      ButtonSize.large => 24,
      ButtonSize.extraLarge => 28,
    },
    min: 8,
    max: 64,
    description: 'Overrides the default icon size from the button size.',
  );

  return AppIconButton(
    icon: icon,
    iconSelected: iconSelected,
    color: color,
    size: size,
    style: style,
    isCircular: isCircular,
    isSelected: isSelected,
    isDisabled: isDisabled,
    iconColor: iconColor,
    iconSize: iconSize,
    onPressed: () {},
  );
}
