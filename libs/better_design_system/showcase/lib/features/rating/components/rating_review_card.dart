import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/feedback_tag/feedback_tag.dart';
import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class RatingReviewCard extends StatelessWidget {
  const RatingReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 12,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.three,
                  size: AvatarSize.size48px,
                ),
                Text('Derek Richardson', style: context.textTheme.titleSmall),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                AppRatingIndicator(
                  style: RatingIndicatorStyle.longWithoutText,
                  rating: 3.5,
                ),
                Text.rich(
                  TextSpan(
                    text: '3.5 ',
                    style: context.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '- 2h ago',
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: context.textTheme.bodyMedium?.variant(context),
            ),
            SizedBox(height: 24),
            Row(
              spacing: 16,
              children: <Widget>[
                AppFeedbackTag(
                  title: '25',
                  type: FeedbackTagType.disike,
                  style: FeedbackTagStyle.ghost,
                ),
                AppFeedbackTag(
                  title: '100',
                  type: FeedbackTagType.like,
                  style: FeedbackTagStyle.ghost,
                ),
                Row(
                  spacing: 4,
                  children: <Widget>[
                    Icon(
                      BetterIcons.bubbleChatOutline,
                      size: 16,
                      color: context.colors.onSurface,
                    ),
                    Text('21 Replies', style: context.textTheme.labelMedium),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFilledButton(onPressed: () {}, text: 'Say Something'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
