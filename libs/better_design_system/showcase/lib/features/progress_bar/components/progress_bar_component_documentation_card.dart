import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ProgressBarComponentDocumentationCard extends StatelessWidget {
  const ProgressBarComponentDocumentationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  spacing: 12,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Icon(
                        BetterIcons.folder01Filled,
                        size: 20,
                        color: context.colors.insight,
                      ),
                    ),
                    Text('Volume Control', style: context.textTheme.titleSmall),
                  ],
                ),
                Icon(
                  BetterIcons.moreHorizontalCircle01Filled,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            AppLinearProgressBar(
              label: 'Label',
              hasSubtitleIcon: false,
              subtitle: '20/30 Components documented',
              onCancelPressed: () {},
              progress: 0.6,
              showProgressNumber: true,
              linearProgressBarStatus: LinearProgressBarStatus.uploading,
              linearProgressBarNumberPosition:
                  LinearProgressBarNumberPosition.right,
            ),
          ],
        ),
      ),
    );
  }
}
