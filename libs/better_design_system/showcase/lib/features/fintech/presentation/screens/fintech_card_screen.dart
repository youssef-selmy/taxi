import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

import '../components/fintech_saved_payment_methods_carousel.dart';

@RoutePage()
class FintechCardScreen extends StatelessWidget {
  const FintechCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Card', style: context.textTheme.titleSmall)],
              ),
            ),
            SizedBox(height: 16),
            FintechSavedPaymentMethodsCarousel(),
            SizedBox(height: 24),
            Text('Card Information', style: context.textTheme.titleSmall),
            SizedBox(height: 16),

            Column(
              spacing: 16,
              children: [
                AppTextField(
                  initialValue: 'Sara Temple',
                  label: 'Card Name',
                  isFilled: false,
                  readOnly: true,
                ),
                AppTextField(
                  initialValue: '2598 6329 9657 0206',
                  label: 'Card Number',
                  isFilled: false,
                  readOnly: true,
                ),
                Row(
                  spacing: 16,
                  children: <Widget>[
                    Expanded(
                      child: AppTextField(
                        initialValue: '09/23',
                        label: '09/23',
                        isFilled: false,
                        readOnly: true,
                      ),
                    ),
                    Expanded(
                      child: AppTextField(
                        initialValue: 'CVV',
                        label: '691',
                        isFilled: false,
                        readOnly: true,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: AppFilledButton(
                        onPressed: () {},
                        text: 'Add New Card',
                        prefixIcon: BetterIcons.add01Outline,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        onPressed: () {},
                        text: 'Edit Card',
                        prefixIcon: BetterIcons.pencilEdit01Outline,
                        color: SemanticColor.neutral,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
