import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/kanban_board/kanban_board.dart';
import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class HrPlatformKanbanBoardCard extends StatelessWidget {
  const HrPlatformKanbanBoardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppKanbanBoard(
      columns: [
        KColumn(
          header: KColumnHeader(
            color: SemanticColor.success,
            title: 'New Applications',
            prefix: Container(
              height: 12,
              width: 12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SemanticColor.success.main(context),
              ),
            ),
            trailing: [
              AppBadge(
                text: '3',
                color: SemanticColor.success,
                isRounded: true,
                style: BadgeStyle.fill,
              ),
              const SizedBox(width: 12),
              AppIconButton(
                icon: BetterIcons.add01Outline,
                size: ButtonSize.small,
              ),
            ],
            style: KColumnHeaderStyle.detached,
          ),
          children: [
            CardItem(
              id: '1',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.one,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Omar Arcand',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Omar@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('92%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '2',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.one,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Angel Dokidis',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Angel@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('85%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '3',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'No Portfolio',
                          color: SemanticColor.error,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.one,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jaydon Philips',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Jaydon@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('64%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AppTextButton(
                        onPressed: () {},
                        text: 'Decline Application',
                        color: SemanticColor.error,
                        size: ButtonSize.small,
                        prefixIcon: BetterIcons.cancel01Outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          value: null,
        ),
        KColumn(
          header: KColumnHeader(
            color: SemanticColor.warning,
            title: 'HR Interview',
            prefix: Container(
              height: 12,
              width: 12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SemanticColor.warning.main(context),
              ),
            ),
            trailing: [
              AppBadge(
                text: '4',
                color: SemanticColor.warning,
                isRounded: true,
                style: BadgeStyle.fill,
              ),
              const SizedBox(width: 12),
              AppIconButton(
                icon: BetterIcons.add01Outline,
                size: ButtonSize.small,
              ),
            ],
            style: KColumnHeaderStyle.detached,
          ),
          children: [
            CardItem(
              id: '1',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.six,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Allison Donin',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Allison@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('81%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reviews by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '2',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.seven,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marilyn Torff',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Marilyn@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('97%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reviews by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '3',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.five,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kierra Torff',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Kierra@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('100%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reviews by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '4',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.one,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Adison Arcand',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Adison@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resume Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('75%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppTextButton(
                          onPressed: () {},
                          text: 'View Resume',
                          size: ButtonSize.small,
                          prefix: Icon(
                            BetterIcons.file01Outline,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          color: SemanticColor.neutral,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reviews by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          value: null,
        ),
        KColumn(
          header: KColumnHeader(
            color: SemanticColor.insight,
            title: 'Technical Interview',
            prefix: Container(
              height: 12,
              width: 12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SemanticColor.insight.main(context),
              ),
            ),
            trailing: [
              AppBadge(
                text: '3',
                color: SemanticColor.insight,
                isRounded: true,
                style: BadgeStyle.fill,
              ),
              const SizedBox(width: 12),
              AppIconButton(
                icon: BetterIcons.add01Outline,
                size: ButtonSize.small,
              ),
            ],
            style: KColumnHeaderStyle.detached,
          ),
          children: [
            CardItem(
              id: '1',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.eight,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dulce Saris',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Dulce@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('93%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppBadge(
                          text: 'Qualified',
                          color: SemanticColor.success,
                          isRounded: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Interviewed by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '2',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.one,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Haylie Donin',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Haylie@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('98%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppBadge(
                          text: 'Qualified',
                          color: SemanticColor.success,
                          isRounded: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Interviewed by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '3',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.two,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Talan Dorwart',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Talan@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('63%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppBadge(
                          text: 'Not Qualified',
                          color: SemanticColor.warning,
                          isRounded: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Interviewed by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CardItem(
              id: '4',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Portfolio Submitted',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.four,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maren Torff',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Maren@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('61%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppBadge(
                          text: 'Not Qualified',
                          color: SemanticColor.warning,
                          isRounded: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Interviewed by',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tiana Philips',
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          value: null,
        ),
        KColumn(
          header: KColumnHeader(
            color: SemanticColor.primary,
            title: 'Hired',
            prefix: Container(
              height: 12,
              width: 12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SemanticColor.primary.main(context),
              ),
            ),
            trailing: [
              AppBadge(
                text: '1',
                color: SemanticColor.primary,
                isRounded: true,
                style: BadgeStyle.fill,
              ),
              const SizedBox(width: 12),
              AppIconButton(
                icon: BetterIcons.add01Outline,
                size: ButtonSize.small,
              ),
            ],
            style: KColumnHeaderStyle.detached,
          ),
          children: [
            CardItem(
              id: '2',
              widget: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppBadge(
                          text: 'Hired',
                          color: SemanticColor.primary,
                          isRounded: true,
                        ),
                        const Spacer(),
                        AppIconButton(
                          icon: BetterIcons.moreHorizontalCircle01Outline,
                          size: ButtonSize.small,
                          iconColor: context.colors.onSurfaceVariant,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: ImageFaker().person.three,
                          size: AvatarSize.size32px,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chance Franci',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Chance@better.com',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 11.5),
                      child: AppDivider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Score',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            Text('93%', style: context.textTheme.titleSmall),
                          ],
                        ),
                        const Spacer(),
                        AppBadge(
                          text: 'Qualified',
                          color: SemanticColor.success,
                          isRounded: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          value: null,
        ),
      ],
    );
  }
}
