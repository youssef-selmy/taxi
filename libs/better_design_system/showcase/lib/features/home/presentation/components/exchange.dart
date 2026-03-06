import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AppExchange extends StatelessWidget {
  const AppExchange({super.key});

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
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Exchange', style: context.textTheme.titleSmall),
                  const Spacer(),
                  const SizedBox(width: 8.0),
                  AppOutlinedButton(
                    onPressed: () {},
                    size: ButtonSize.medium,
                    color: SemanticColor.neutral,
                    text: 'Currencies',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppClickableCard(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppDropdownField.single(
                              items: [
                                AppDropdownItem(
                                  title: 'USD',
                                  value: 'USD',
                                  prefix: Assets.images.countries.unitedStates
                                      .image(width: 24, height: 24),
                                ),
                                AppDropdownItem(
                                  title: 'EUR',
                                  value: 'EUR',
                                  prefix: Assets
                                      .images
                                      .countries
                                      .europeanUnionSvg
                                      .image(width: 24, height: 24),
                                ),
                                AppDropdownItem(
                                  title: 'GBP',
                                  value: 'GBP',
                                  prefix: Assets.images.countries.unitedKingdom
                                      .image(width: 24, height: 24),
                                ),
                              ],
                              type: DropdownFieldType.inLine,
                              initialValue: 'USD',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 31.5,
                            ),
                            child: IconButton.outlined(
                              onPressed: () {},
                              iconSize: 20,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              color: context.colors.onSurface,
                              icon: const Icon(
                                BetterIcons.arrowDataTransferHorizontalOutline,
                              ),
                            ),
                          ),
                          Expanded(
                            child: AppDropdownField.single(
                              items: [
                                AppDropdownItem(
                                  title: 'USD',
                                  value: 'USD',
                                  prefix: Assets.images.countries.unitedStates
                                      .image(width: 24, height: 24),
                                ),
                                AppDropdownItem(
                                  title: 'EUR',
                                  value: 'EUR',
                                  prefix: Assets
                                      .images
                                      .countries
                                      .europeanUnionSvg
                                      .image(width: 24, height: 24),
                                ),
                                AppDropdownItem(
                                  title: 'GBP',
                                  value: 'GBP',
                                  prefix: Assets.images.countries.unitedKingdom
                                      .image(width: 24, height: 24),
                                ),
                              ],
                              type: DropdownFieldType.inLine,
                              initialValue: 'EUR',
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppDivider(),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\$115.00',
                            style: context.textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Available:',
                                style: context.textTheme.labelLarge?.variant(
                                  context,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '\$12,000,000',
                                style: context.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppDivider(),
                    Container(
                      color: context.colors.surfaceVariantLow,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '1 USD = ',
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '0.94 EUR',
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 16.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tax (2%)',
                          style: context.textTheme.labelLarge?.variant(context),
                        ),
                        Text('\$4.00', style: context.textTheme.labelLarge),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Exchange Fee (1%)',
                          style: context.textTheme.labelLarge?.variant(context),
                        ),
                        Text('\$2.00', style: context.textTheme.labelLarge),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Amount',
                          style: context.textTheme.labelLarge?.variant(context),
                        ),
                        Text('\$88.8', style: context.textTheme.labelLarge),
                      ],
                    ),
                    const SizedBox(height: 43.2),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: AppOutlinedButton(
                        text: 'Exchange',
                        onPressed: () {},
                        color: SemanticColor.neutral,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
