import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppOutlinedButton)
Widget outlinedButtonUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Outlined Button', // Using a generic default
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
    label: 'Base Color (Theme)',
    options: SemanticColor.values,
    initialOption: SemanticColor.primary, // Matches widget default
    labelBuilder: (value) => value.name,
    description:
        'Base theme color, primarily affecting border/text unless overridden.',
  );

  final size = context.knobs.object.dropdown<ButtonSize>(
    label: 'Button Size',
    options: ButtonSize.values,
    initialOption: ButtonSize.large, // Matches widget default
    labelBuilder: (value) => value.name,
    description: 'Select the size impacting padding, text, and icon scaling.',
  );

  final alignment = context.knobs.object.dropdown<MainAxisAlignment>(
    label: 'Alignment',
    options: [
      MainAxisAlignment.start,
      MainAxisAlignment.center,
      MainAxisAlignment.end,
    ],
    initialOption: MainAxisAlignment.center, // Matches widget default
    labelBuilder: (value) => value.name,
    description: 'Controls content alignment within the button.',
  );

  final prefixIcon = showPrefixIcon ? BetterIcons.userMultipleOutline : null;
  final suffixIcon = showSuffixIcon ? BetterIcons.flashOutline : null;

  return AppOutlinedButton(
    text: text,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon, // Widget handles hiding suffix if isLoading
    isLoading: isLoading,
    isDisabled: isDisabled,
    color: color,
    size: size,
    alignment: alignment,
    backgroundColor: null,
    foregroundColor: null,
    borderColor: null,
    prefix: null,
    suffix: null,
    onPressed: () {},
  );
}
