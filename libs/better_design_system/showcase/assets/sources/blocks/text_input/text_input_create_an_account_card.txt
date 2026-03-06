import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextInputCreateAnAccountCard extends StatelessWidget {
  const TextInputCreateAnAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surfaceVariant,
              ),
              child: Center(
                child: Assets.images.iconsTwotone.call02.svg(
                  width: 40,
                  height: 40,
                  colorFilter: ColorFilter.mode(
                    context.colors.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Create an Account', style: context.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Enter your phone number to continue',
              style: context.textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppPhoneNumberField(
                initialValue: ('US', null),
                hint: '--- --- ---',
                label: 'Phone Number',
                isRequired: true,
                isFilled: false,
                sublabel: '(Sublabel)',
                helpText: 'Insert text here to help users.',
                showEditButton: true,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: AppFilledButton(
                onPressed: () {},
                text: 'Send SMS',
                size: ButtonSize.extraLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
