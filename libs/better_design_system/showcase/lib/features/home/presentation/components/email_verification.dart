import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AppEmailVerification extends StatelessWidget {
  const AppEmailVerification({super.key});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                bottom: 14.0,
                left: 20.0,
                right: 8.0,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: context.colors.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(BetterIcons.blockedFilled),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Verification',
                          style: context.textTheme.labelLarge,
                        ),
                        Text(
                          'Enter your email to receive confirmation',
                          style: context.textTheme.bodyMedium?.variantLow(
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(
                    prefixIcon: const Icon(BetterIcons.mail02Outline),
                    iconPadding: EdgeInsets.only(left: 6),
                    label: 'Email Address',
                    hint: 'email@address.com',
                    keyboardType: TextInputType.emailAddress,
                    isFilled: false,
                  ),
                ],
              ),
            ),
            AppDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    child: AppFilledButton(onPressed: () {}, text: 'Send Code'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
