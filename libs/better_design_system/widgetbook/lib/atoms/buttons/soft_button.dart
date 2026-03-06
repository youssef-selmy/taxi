import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSoftButton)
Widget softButtonUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Soft Button', // Using a generic default
    description: 'The text label displayed on the button.',
  );

  final showPrefixIcon = context.knobs.boolean(
    label: 'Show Prefix Icon',
    initialValue: true,
    description: 'Toggle the visibility of the icon before the text.',
  );

  final showSuffixIcon = context.knobs.boolean(
    label: 'Show Suffix Icon',
    initialValue: false,
    description: 'Toggle the visibility of the icon after the text.',
  );

  final isLoading = context.knobs.boolean(
    label: 'Is Loading',
    initialValue: false,
    description: 'Simulates a loading state.',
  );

  final isDisabled = context.knobs.boolean(
    label: 'Is Disabled',
    initialValue: false,
    description: 'Controls the enabled/disabled state of the button.',
  );

  final color = context.knobs.object.dropdown<SemanticColor>(
    label: 'Semantic Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.primary, // Matches widget default
    labelBuilder: (value) => value.name,
    description: 'Defines the base color scheme for the button.',
  );

  final size = context.knobs.object.dropdown<ButtonSize>(
    label: 'Button Size',
    options: ButtonSize.values,
    initialOption: ButtonSize.large, // Matches widget default
    labelBuilder: (value) => value.name,
    description: 'Select the size impacting padding, text, and icon scaling.',
  );

  final prefixIcon = showPrefixIcon ? BetterIcons.userMultipleOutline : null;
  final suffixIcon = showSuffixIcon ? BetterIcons.flashOutline : null;

  return AppSoftButton(
    text: text,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon, // Widget handles hiding suffix if isLoading
    isLoading: isLoading,
    isDisabled: isDisabled,
    color: color,
    size: size,
    onPressed: () {},
  );
}
