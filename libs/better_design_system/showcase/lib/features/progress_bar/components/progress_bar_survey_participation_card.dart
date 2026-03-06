import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class ProgressBarSurveyParticipationCard extends StatefulWidget {
  const ProgressBarSurveyParticipationCard({super.key});

  @override
  State<ProgressBarSurveyParticipationCard> createState() =>
      _ProgressBarSurveyParticipationCardState();
}

class _ProgressBarSurveyParticipationCardState
    extends State<ProgressBarSurveyParticipationCard> {
  double avatarSpacing = 20;

  final List<String> avatarsUrl = [
    ImageFaker().person.one,
    ImageFaker().person.two,
    ImageFaker().person.three,
    ImageFaker().person.four,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 440,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Survey Participation', style: context.textTheme.titleSmall),
            SizedBox(height: 8),
            Text(
              'Help us improve our new feature',
              style: context.textTheme.bodySmall?.variant(context),
            ),

            AppDivider(height: 36),
            Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    SizedBox(width: 100, height: 39),
                    ...List.generate(
                      avatarsUrl.length,
                      (index) => Positioned(
                        left: index == 0 ? 0.0 : (avatarSpacing * index),
                        child: _buildAvatar(context, avatarsUrl[index]),
                      ),
                    ),
                  ],
                ),
                Text(
                  '+21 others',
                  style: context.textTheme.bodySmall?.variant(context),
                ),
              ],
            ),
            AppLinearProgressBar(
              hasSubtitleIcon: false,
              subtitle: '25 of 100 Responses received',
              onCancelPressed: () {},
              progress: 0.25,
              showProgressNumber: true,
              linearProgressBarStatus: LinearProgressBarStatus.uploading,
              linearProgressBarNumberPosition:
                  LinearProgressBarNumberPosition.top,
            ),

            SizedBox(height: 24),

            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'View Participants',
                  ),
                ),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Share Survey',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 3, color: context.colors.surface),
      ),
      child: AppAvatar(imageUrl: imageUrl, size: AvatarSize.size32px),
    );
  }
}
