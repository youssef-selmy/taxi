import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AppSavedActions extends StatelessWidget {
  const AppSavedActions({super.key});

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
              padding: const EdgeInsets.all(13.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Saved Actions', style: context.textTheme.titleSmall),
                  AppOutlinedButton(
                    text: 'View all',
                    onPressed: () {},
                    size: ButtonSize.medium,
                    color: SemanticColor.neutral,
                  ),
                ],
              ),
            ),
            AppDivider(),
            Padding(
              padding: const EdgeInsets.all(13.6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: context.colors.outline,
                        width: 0.85,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.8),
                      child: Icon(
                        BetterIcons.ideaFilled,
                        color: context.colors.secondary,
                        size: 20.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.2),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Utility bills',
                                    style: context.textTheme.labelMedium,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.2,
                                    ),
                                    child: Text(
                                      '\$30.00',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ),
                                  AppIconButton(
                                    icon: BetterIcons.arrowRight01Outline,
                                    size: ButtonSize.small,
                                    iconColor: context.colors.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.6),
              child: AppDivider(),
            ),

            Padding(
              padding: const EdgeInsets.all(13.6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: context.colors.outline,
                        width: 0.85,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.8),
                      child: Icon(
                        BetterIcons.home01Filled,
                        color: context.colors.onSurfaceVariant,
                        size: 20.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.2),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Mortgage Installment',
                                    style: context.textTheme.labelMedium,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.2,
                                    ),
                                    child: Text(
                                      '\$200.00',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ),
                                  AppIconButton(
                                    icon: BetterIcons.arrowRight01Outline,
                                    size: ButtonSize.small,
                                    iconColor: context.colors.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.6),
              child: AppDivider(),
            ),
            Padding(
              padding: const EdgeInsets.all(13.6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: context.colors.outline,
                        width: 0.85,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.8),
                      child: Icon(
                        BetterIcons.building02Filled,
                        color: Color(0xFF6662FF),
                        size: 20.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.2),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Daycare Fee',
                                    style: context.textTheme.labelMedium,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.2,
                                    ),
                                    child: Text(
                                      '\$70.00',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ),
                                  AppIconButton(
                                    icon: BetterIcons.arrowRight01Outline,
                                    size: ButtonSize.small,
                                    iconColor: context.colors.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.6),
              child: AppDivider(),
            ),
            Padding(
              padding: const EdgeInsets.all(13.6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: context.colors.outline,
                        width: 0.85,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.8),
                      child: Icon(
                        BetterIcons.car05Filled,
                        color: context.colors.insight,
                        size: 20.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.2),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Car Insurance',
                                    style: context.textTheme.labelMedium,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.2,
                                    ),
                                    child: Text(
                                      '\$100.00',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ),
                                  AppIconButton(
                                    icon: BetterIcons.arrowRight01Outline,
                                    size: ButtonSize.small,
                                    iconColor: context.colors.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ],
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
              padding: const EdgeInsets.all(13.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppOutlinedButton(
                      onPressed: () {},
                      text: 'Save a new Action',
                      color: SemanticColor.neutral,
                      prefixIcon: BetterIcons.addCircleOutline,
                    ),
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
