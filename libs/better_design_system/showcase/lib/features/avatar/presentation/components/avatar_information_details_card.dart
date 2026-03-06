import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class AvatarInformationDetailsCard extends StatelessWidget {
  const AvatarInformationDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 302,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Information Details', style: context.textTheme.labelMedium),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.colors.outline),
              ),
              child: Row(
                spacing: 8,
                children: [
                  AppAvatar(
                    imageUrl: ImageFaker().person.one,
                    size: AvatarSize.size40px,
                    statusBadgeType: StatusBadgeType.offline,
                  ),
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Phillip George',
                        style: context.textTheme.labelLarge,
                      ),
                      Text(
                        'last active 2h ago',
                        style: context.textTheme.bodySmall?.variant(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Registered on',
              style: context.textTheme.labelSmall?.variant(context),
            ),
            SizedBox(height: 4),
            Text('5 Apr, 2025', style: context.textTheme.labelMedium),

            AppDivider(height: 20),
            Text(
              'Rating',
              style: context.textTheme.labelSmall?.variant(context),
            ),
            SizedBox(height: 4),
            AppRatingIndicator(
              style: RatingIndicatorStyle.compactWithShortText,
              rating: 3.5,
            ),
            AppDivider(height: 20),
            Text(
              'Status',
              style: context.textTheme.labelSmall?.variant(context),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Approved', style: context.textTheme.labelMedium),
                AppOutlinedButton(
                  onPressed: () {},
                  text: 'Update Status',
                  size: ButtonSize.small,
                  color: SemanticColor.neutral,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
