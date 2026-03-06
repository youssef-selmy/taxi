import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class AppUserPost extends StatelessWidget {
  const AppUserPost({super.key});

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
                children: [
                  AppAvatar(
                    imageUrl: ImageFaker().person.five,
                    size: AvatarSize.size48px,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mandy Rose', style: context.textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text(
                        'a minute ago',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(BetterIcons.arrowUp01Outline),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  AppTextField(
                    initialValue:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\n',
                    helpText: 'Liked by Alex and 32 others',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 10.5),
                  AppDivider(),
                  const SizedBox(height: 10.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(BetterIcons.delete03Outline),
                          iconSize: 20,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(BetterIcons.share07Outline),
                          iconSize: 20,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: IconButton.filled(
                          onPressed: () {},
                          icon: const Icon(BetterIcons.allBookmarkFilled),
                          iconSize: 20,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(BetterIcons.bubbleChatOutline),
                          iconSize: 20,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
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
