import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/pin_field/pin_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class PinInputEnterOtpCard extends StatelessWidget {
  const PinInputEnterOtpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter OTP Code', style: context.textTheme.headlineMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enter 6-digit code that sent to +1 (888)-888-888',
              style: context.textTheme.bodyMedium?.variant(context),
            ),
            const SizedBox(height: 32),
            AppPinField(length: 6, initialValue: '126416', autofocus: false),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {},
                    text: 'Resend Code in 1:54',
                    size: ButtonSize.medium,
                    color: SemanticColor.neutral,
                    isLoading: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {},
                    text: 'Change Phone Number',
                    size: ButtonSize.medium,
                    color: SemanticColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppFilledButton(
                    text: 'Confirm',
                    onPressed: () {},
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
