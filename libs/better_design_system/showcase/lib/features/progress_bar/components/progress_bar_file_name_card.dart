import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ProgressBarFileNameCard extends StatelessWidget {
  const ProgressBarFileNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Icon(
                  BetterIcons.folder01Filled,
                  size: 40,
                  color: context.colors.insight,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text('File name', style: context.textTheme.labelLarge),
                    Text(
                      '6,1 mb / 8,8 mb',
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                AppCircularProgressBar(
                  size: CircularProgressBarSize.size40px,
                  progress: 0.75,
                  showProgressNumber: true,
                  status: CircularProgressBarStatus.uploading,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: context.colors.outline),
                  ),
                  child: Icon(
                    BetterIcons.cancel01Outline,
                    size: 20,
                    color: context.colors.onSurface,
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
