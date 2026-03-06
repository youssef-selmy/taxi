import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class DividerMessageListCard extends StatelessWidget {
  const DividerMessageListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 338,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Message List', style: context.textTheme.titleSmall),
                AppIconButton(
                  icon: BetterIcons.search01Filled,
                  size: ButtonSize.medium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMessageItem(
              context,
              name: 'Eden Gross',
              message:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
              time: '12.55 pm',
              unreadCount: 2,
              avatarUrl: ImageFaker().person.one,
              containerColor: Color(0xFFe0f4fd),
              iconColor: Color(0xFF03a9f4),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.5),
              child: const AppDivider(),
            ),
            _buildMessageItem(
              context,
              name: 'Graham Depue',
              message:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
              time: '12.55 pm',
              unreadCount: 1,
              avatarUrl: ImageFaker().person.two,
              containerColor: Color(0xFFfeebf3),
              iconColor: Color(0xFFf75e9f),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.5),
              child: const AppDivider(),
            ),
            _buildMessageItem(
              context,
              name: 'Timothy Vasquez',
              message:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
              time: '12.55 pm',
              unreadCount: 5,
              avatarUrl: ImageFaker().person.three,
              containerColor: Color(0xFFe8e7ff),
              iconColor: Color(0xFF6662ff),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(
    BuildContext context, {
    required String name,
    required String message,
    required String time,
    required int? unreadCount,
    required String avatarUrl,
    required Color containerColor,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(BetterIcons.userFilled, size: 20, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: context.textTheme.labelLarge),
                  const SizedBox(width: 6),
                  if (unreadCount != null)
                    AppBadge(
                      text: unreadCount.toString(),
                      color: SemanticColor.error,
                      style: BadgeStyle.fill,
                      size: BadgeSize.small,
                      isRounded: true,
                    ),
                  const Spacer(),
                  Text(
                    time,
                    style: context.textTheme.labelSmall!.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
