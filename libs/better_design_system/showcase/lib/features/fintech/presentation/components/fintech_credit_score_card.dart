import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FintechCreditScoreCard extends StatelessWidget {
  const FintechCreditScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Credit Score', style: context.textTheme.titleSmall),
              AppOutlinedButton(
                onPressed: () {},
                text: 'Details',
                color: SemanticColor.neutral,
                size: ButtonSize.medium,
              ),
            ],
          ),
          AppDivider(height: 32),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.warningContainer,
            ),
            child: Icon(
              BetterIcons.smileFilled,
              size: 36,
              color: context.colors.warning,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Your credit score is 710',
            style: context.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'This score is considered to be Excellent.',
            style: context.textTheme.labelMedium?.variant(context),
          ),
          SizedBox(height: 16),
          AppLinearProgressBar(
            linearProgressBarStatus: LinearProgressBarStatus.uploading,
            progress: 0.7,
          ),
        ],
      ),
    );
  }
}
