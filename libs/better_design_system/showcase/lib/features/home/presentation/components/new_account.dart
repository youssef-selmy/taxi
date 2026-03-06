import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppNewAccount extends StatelessWidget {
  const AppNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16.0)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create an Account',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppPhoneNumberField(
                initialValue: ("US", null),
                hint: '--- --- ---',
                label: 'Phone Number',
                isRequired: true,
                isFilled: false,
                helpText: 'We will send you a verification code.',
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: AppFilledButton(onPressed: () {}, text: 'Send Code'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
