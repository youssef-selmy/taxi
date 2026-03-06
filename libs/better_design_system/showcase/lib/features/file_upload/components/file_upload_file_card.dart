import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/molecules/file_upload/file_upload_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FileUploadFileCard extends StatelessWidget {
  const FileUploadFileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Upload file', style: context.textTheme.titleMedium),
                const Spacer(),
                AppIconButton(
                  icon: BetterIcons.folder01Outline,
                  size: ButtonSize.small,
                ),
                const SizedBox(width: 16),
                AppIconButton(
                  icon: BetterIcons.cancelCircleOutline,
                  size: ButtonSize.small,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Text(
                'Add your documents here. you can add up to 10 files.',
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ),
            Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFileUploadCard(
                  isDashed: true,
                  primaryMessage: 'Drag & drop files to upload',
                  secondaryMessage:
                      'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
                  buttonText: 'Upload file',
                  onFilesSelected: (context) async {},
                  style: UploadCardStyle.outlined,
                ),
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
                              'File name',
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
          ],
        ),
      ),
    );
  }
}
