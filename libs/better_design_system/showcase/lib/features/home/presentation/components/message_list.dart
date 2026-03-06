import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AppMessageList extends StatelessWidget {
  const AppMessageList({super.key});

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Message List', style: context.textTheme.titleSmall),
                  AppIconButton(
                    onPressed: () {},
                    icon: BetterIcons.search01Filled,
                    size: ButtonSize.medium,
                    color: SemanticColor.neutral,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: context.colors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        BetterIcons.userFilled,
                        color: context.colors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Eden Gross',
                                    style: context.textTheme.labelLarge,
                                  ),
                                  const SizedBox(width: 6),
                                  AppBadge(
                                    text: '2',
                                    size: BadgeSize.small,
                                    isRounded: true,
                                    color: SemanticColor.error,
                                    style: BadgeStyle.fill,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
                                style: context.textTheme.bodySmall?.variant(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '12:55 PM',
                          style: context.textTheme.labelSmall?.variant(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.5),
                child: AppDivider(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: context.colors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        BetterIcons.userFilled,
                        color: context.colors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Graham Depue',
                                    style: context.textTheme.labelLarge,
                                  ),
                                  const SizedBox(width: 6),
                                  AppBadge(
                                    text: '1',
                                    size: BadgeSize.small,
                                    isRounded: true,
                                    color: SemanticColor.error,
                                    style: BadgeStyle.fill,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
                                style: context.textTheme.bodySmall?.variant(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '12:55 pm',
                          style: context.textTheme.labelSmall?.variant(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.5),
                child: AppDivider(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: context.colors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        BetterIcons.userFilled,
                        color: context.colors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Timothy Vasquez',
                                    style: context.textTheme.labelLarge,
                                  ),
                                  const SizedBox(width: 6),
                                  AppBadge(
                                    text: '5',
                                    size: BadgeSize.small,
                                    isRounded: true,
                                    color: SemanticColor.error,
                                    style: BadgeStyle.fill,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
                                style: context.textTheme.bodySmall?.variant(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '12:55 pm',
                          style: context.textTheme.labelSmall?.variant(context),
                        ),
                      ],
                    ),
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
