import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/molecules/file_upload/file_upload_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FileUploadDocumentsCard extends StatelessWidget {
  const FileUploadDocumentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 443,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 8, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upload Documents', style: context.textTheme.labelLarge),
                AppIconButton(
                  icon: BetterIcons.cancelCircleOutline,
                  iconColor: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In order to verification above documents we require below documents uploaded',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• ID Card\n• Driver License',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: AppFileUploadCard(
                    isDashed: true,
                    primaryMessage: 'Drag & drop files to upload',
                    secondaryMessage:
                        'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
                    buttonText: 'Upload file',
                    onFilesSelected: (context) async {},
                    style: UploadCardStyle.filled,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: context.colors.outline),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.images.iconsTwotone.file02.svg(
                            colorFilter: ColorFilter.mode(
                              context.colors.primary,
                              BlendMode.srcIn,
                            ),
                            width: 40,
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                'ID Card',
                                style: context.textTheme.labelLarge,
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  Text(
                                    '12 MB',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color:
                                              context
                                                  .colors
                                                  .onSurfaceVariantLow,
                                        ),
                                  ),
                                  Text(
                                    '-',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color:
                                              context
                                                  .colors
                                                  .onSurfaceVariantLow,
                                        ),
                                  ),
                                  Text(
                                    'Uploading...',
                                    style: context.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          AppIconButton(
                            icon: BetterIcons.cancelCircleOutline,
                            size: ButtonSize.small,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AppLinearProgressBar(
                        progress: 0.3,
                        linearProgressBarStatus:
                            LinearProgressBarStatus.uploading,
                        showProgressNumber: true,
                        linearProgressBarNumberPosition:
                            LinearProgressBarNumberPosition.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: context.colors.outline),
                  ),
                  width: double.infinity,
                  child: Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.images.iconsTwotone.file02.svg(
                        colorFilter: ColorFilter.mode(
                          context.colors.primary,
                          BlendMode.srcIn,
                        ),
                        width: 40,
                        height: 40,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              'Driver License',
                              style: context.textTheme.labelLarge,
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Text(
                                  '12 MB',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colors.onSurfaceVariantLow,
                                  ),
                                ),
                                Text(
                                  '-',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colors.onSurfaceVariantLow,
                                  ),
                                ),
                                Text(
                                  'Completed',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colors.success,
                                  ),
                                ),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: context.colors.success,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    BetterIcons.tick02Outline,
                                    color: context.colors.onSuccess,
                                    size: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppIconButton(
                        icon: BetterIcons.delete03Outline,
                        size: ButtonSize.small,
                        iconColor: context.colors.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Cancel',
                    color: SemanticColor.neutral,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppFilledButton(onPressed: () {}, text: 'Upload'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
