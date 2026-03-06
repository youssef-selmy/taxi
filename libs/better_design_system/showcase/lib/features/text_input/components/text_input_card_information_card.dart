import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextInputCardInformationCard extends StatelessWidget {
  const TextInputCardInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Information', style: context.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 24),
              child: Text(
                'Please enter your card information',
                style: context.textTheme.bodyMedium,
              ),
            ),
            Column(
              spacing: 24,
              children: [
                AppTextField(
                  prefixIcon: Icon(
                    BetterIcons.creditCardOutline,
                    color: context.colors.onSurfaceVariant,
                    size: 20,
                  ),
                  label: 'Card Number',
                  hint: 'Enter card number',
                ),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: AppTextField(label: 'Exp Date', hint: 'MM/YY'),
                    ),
                    Expanded(child: AppTextField(label: 'CVV', hint: '123')),
                  ],
                ),
                AppDropdownField.single(
                  label: 'Country',
                  hint: 'Select an country',
                  prefixIcon: BetterIcons.globe02Outline,
                  items: [
                    AppDropdownItem(title: 'United States', value: 'US'),
                    AppDropdownItem(title: 'Canada', value: 'CA'),
                    AppDropdownItem(title: 'United Kingdom', value: 'GB'),
                    AppDropdownItem(title: 'Australia', value: 'AU'),
                    AppDropdownItem(title: 'Germany', value: 'DE'),
                    AppDropdownItem(title: 'France', value: 'FR'),
                    AppDropdownItem(title: 'Japan', value: 'JP'),
                    AppDropdownItem(title: 'Mexico', value: 'MX'),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  fillColor: context.colors.surfaceVariant,
                ),
                AppTextField(label: 'Zip Code', hint: 'Enter zip code'),
                AppTextField(label: 'Cardholder Name', hint: 'Enter full name'),
                SizedBox(
                  width: double.infinity,
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Save Card',
                    size: ButtonSize.extraLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
