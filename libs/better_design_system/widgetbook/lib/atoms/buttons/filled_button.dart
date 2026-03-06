import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFilledButton)
Widget filledButtonUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Filled Button',
    description: 'The text label displayed on the button.',
  );

  final showPrefixIcon = context.knobs.boolean(
    label: 'Show Prefix Icon',
    initialValue: true,
    description: 'Toggle the visibility of the icon before the text.',
  );

  final showSuffixIcon = context.knobs.boolean(
    label: 'Show Suffix Icon',
    initialValue: true,
    description: 'Toggle the visibility of the icon after the text.',
  );

  final isLoading = context.knobs.boolean(
    label: 'Is Loading',
    initialValue: false,
    description: 'Simulates a loading state, typically showing an indicator.',
  );

  final isDisabled = context.knobs.boolean(
    label: 'Is Disabled',
    initialValue: false,
    description: 'Controls the enabled/disabled state of the button.',
  );

  final color = context.knobs.object.dropdown<SemanticColor>(
    label: 'Semantic Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.primary, // Default color
    labelBuilder: (value) => value.name,
    description: 'Defines the base color scheme (primary, secondary, etc.).',
  );

  final size = context.knobs.object.dropdown<ButtonSize>(
    label: 'Button Size',
    options: ButtonSize.values,
    // Set initialOption to large to match AppFilledButton's default
    initialOption: ButtonSize.large,
    labelBuilder: (value) => value.name,
    description: 'Select the size of the button.',
  );

  final prefixIcon = showPrefixIcon ? Icons.add : null;
  // Suffix icon is also hidden when isLoading is true (handled inside widget)
  final suffixIconData = showSuffixIcon ? Icons.arrow_forward : null;

  return AppFilledButton(
    text: text,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIconData, // Widget handles hiding this if isLoading
    isLoading: isLoading,
    isDisabled: isDisabled,
    color: color,
    size: size,
    onPressed: () {},
  );
}
