import 'package:better_design_system/atoms/buttons/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFloatingActionButton)
Widget floatingActionButtonUseCase(BuildContext context) {
  final text = context.knobs.stringOrNull(
    label: 'Text (Optional)',
    initialValue: null,
    description: 'The optional text label displayed on the button.',
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
    description: 'Defines the base color scheme.',
  );

  final size = context.knobs.object.dropdown<FabSize>(
    label: 'FAB Size',
    options: FabSize.values,
    // Set initialOption to large to match widget default
    initialOption: FabSize.large,
    labelBuilder: (value) => value.name,
    description: 'Select the size of the Floating Action Button.',
  );

  final isFilled = context.knobs.boolean(
    label: 'Is Filled',
    initialValue: true, // Matches widget default
    description: 'Controls if the button has a filled or surface background.',
  );

  final prefixIcon = showPrefixIcon ? Icons.add : null;
  final suffixIcon = showSuffixIcon ? Icons.arrow_forward : null;

  return AppFloatingActionButton(
    text: text,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon, // Widget handles hiding if isLoading
    isLoading: isLoading,
    isDisabled: isDisabled,
    color: color,
    size: size,
    isFilled: isFilled,
    onPressed: () {},
  );
}
