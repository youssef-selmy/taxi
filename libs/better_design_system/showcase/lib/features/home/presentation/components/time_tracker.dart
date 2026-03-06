import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AppTimeTracker extends StatelessWidget {
  const AppTimeTracker({super.key});

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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Tracker', style: context.textTheme.titleSmall),
                  Text('View all', style: context.textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 24),
              AppClickableCard(
                padding: EdgeInsets.zero,
                type: ClickableCardType.elevated,
                elevation: BetterShadow.shadow4,

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      AppDropdownField.single(
                        hint: 'Select project',
                        items: [
                          AppDropdownItem(
                            value: 'Design System',
                            title: 'Design System',
                          ),
                          AppDropdownItem(
                            value: 'BetterTaxi',
                            title: 'BetterTaxi',
                          ),
                          AppDropdownItem(
                            value: 'BetterShop',
                            title: 'BetterShop',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Awaiting',
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              Text(
                                '00:00:00',
                                style: context.textTheme.headlineMedium,
                              ),
                            ],
                          ),
                          AppFilledButton(
                            onPressed: () {},
                            prefixIcon: BetterIcons.playFilled,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextButton(
                    onPressed: () {},
                    text: 'View previous tasks',
                    suffixIcon: BetterIcons.arrowRight01Outline,
                    color: SemanticColor.primary,
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
