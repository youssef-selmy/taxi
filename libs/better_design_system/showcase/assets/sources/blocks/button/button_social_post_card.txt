import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class ButtonSocialPostCard extends StatelessWidget {
  const ButtonSocialPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12,
                  children: <Widget>[
                    AppAvatar(
                      imageUrl: ImageFaker().person.four,
                      size: AvatarSize.size48px,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: <Widget>[
                        Text('Mandy Rose', style: context.textTheme.titleSmall),
                        Text(
                          'a minute ago',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                      ],
                    ),
                  ],
                ),

                Icon(
                  BetterIcons.arrowUp01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.surfaceVariant,
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                style: context.textTheme.bodyMedium?.variant(context),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Liked by Alex and 32 others',
              style: context.textTheme.labelMedium?.variant(context),
            ),

            AppDivider(height: 28),
            Row(
              spacing: 8,
              children: <Widget>[
                Expanded(
                  child: AppIconButton(
                    icon: BetterIcons.delete03Outline,
                    style: IconButtonStyle.outline,
                  ),
                ),
                Expanded(
                  child: AppIconButton(
                    icon: BetterIcons.share07Outline,
                    style: IconButtonStyle.outline,
                  ),
                ),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    prefixIcon: BetterIcons.allBookmarkFilled,
                  ),
                ),
                Expanded(
                  child: AppIconButton(
                    icon: BetterIcons.bubbleChatOutline,
                    style: IconButtonStyle.outline,
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
