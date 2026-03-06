import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/feedback_tag/feedback_tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class BadgeFeedbackCard extends StatelessWidget {
  const BadgeFeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 297,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: <Widget>[
            Row(
              spacing: 8,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.five,
                  size: AvatarSize.size40px,
                ),
                Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Max Brown', style: context.textTheme.labelLarge),
                    Text(
                      '24 May, 2024',
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
              style: context.textTheme.bodySmall?.variant(context),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AppFeedbackTag(
                  title: 'Good route',
                  type: FeedbackTagType.like,
                  style: FeedbackTagStyle.ghost,
                ),
                AppFeedbackTag(
                  title: 'Clean set',
                  type: FeedbackTagType.like,
                  style: FeedbackTagStyle.ghost,
                ),
                AppFeedbackTag(
                  title: 'Dangerous',
                  type: FeedbackTagType.disike,
                  style: FeedbackTagStyle.ghost,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
