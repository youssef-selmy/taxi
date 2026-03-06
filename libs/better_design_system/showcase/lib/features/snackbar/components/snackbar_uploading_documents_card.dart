import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SnackbarUploadingDocumentsCard extends StatelessWidget {
  const SnackbarUploadingDocumentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 464,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 80,
            spreadRadius: -8,
            offset: Offset(0, 24),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.surfaceVariant,
            ),
            child: Icon(
              BetterIcons.cloudUploadOutline,
              size: 20,
              color: context.colors.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uploading Documents',
                  style: context.textTheme.labelLarge,
                ),
                SizedBox(height: 4),
                Text(
                  'Please wait until the upload is complete.',
                  style: context.textTheme.bodySmall?.variant(context),
                ),
                SizedBox(height: 8),
                AppLinearProgressBar(
                  linearProgressBarNumberPosition:
                      LinearProgressBarNumberPosition.right,
                  progress: 0.3,
                  linearProgressBarStatus: LinearProgressBarStatus.uploading,
                  onCancelPressed: () {},
                  showProgressNumber: true,
                  label: 'Label',
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextButton(onPressed: () {}, text: 'Cancel Upload'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
