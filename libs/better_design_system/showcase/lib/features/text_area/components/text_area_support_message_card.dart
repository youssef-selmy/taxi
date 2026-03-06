import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextAreaSupportMessageCard extends StatelessWidget {
  const TextAreaSupportMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 430,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(BetterIcons.headphonesFilled, size: 24),
                ),
                const SizedBox(width: 16),
                Text('Support Message', style: context.textTheme.labelLarge),
                const Spacer(),
                AppIconButton(icon: BetterIcons.cancelCircleOutline),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              spacing: 16,
              children: [
                AppDropdownField.single(
                  hint: 'Select a category',
                  prefixIcon: BetterIcons.menu11Outline,
                  items: [
                    AppDropdownItem(
                      title: 'Select a category',
                      value: 'Select a category',
                    ),
                  ],
                ),
                AppTextField(hint: 'Describe your issue here', maxLines: 9),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Cancel',
                    color: SemanticColor.neutral,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Send Message',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
