import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/molecules/file_upload/file_upload_card.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EcommerceProductImagesCard extends StatelessWidget {
  const EcommerceProductImagesCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Product Images', style: context.textTheme.titleSmall),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFileUploadCard(
                  primaryMessage: 'Drag & drop files to upload',
                  secondaryMessage:
                      'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
                  buttonText: 'Upload file',
                  onFilesSelected: (List<PlatformFile> files) async {
                    // Simulate upload delay
                    await Future.delayed(const Duration(seconds: 1));
                  },
                  style: UploadCardStyle.filled,
                ),
                const SizedBox(height: 16),
                Row(
                  spacing: 8,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Assets.images.products.shoe01.image(
                        height: 64,
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Assets.images.products.shoe02.image(
                        height: 64,
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Assets.images.products.shoe03.image(
                        height: 64,
                        width: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Images', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 240,
                width: 230,
                child: AppFileUploadCard(
                  primaryMessage: 'Drag & drop files to upload',
                  secondaryMessage:
                      'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
                  buttonText: 'Upload file',
                  onFilesSelected: (List<PlatformFile> files) async {
                    // Simulate upload delay
                    await Future.delayed(const Duration(seconds: 1));
                  },
                  style: UploadCardStyle.filled,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Assets.images.products.shoe01.image(fit: BoxFit.cover),
                    Assets.images.products.shoe02.image(fit: BoxFit.cover),
                    Assets.images.products.shoe03.image(fit: BoxFit.cover),
                  ],
                ),
              ),
              // Expanded(
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Assets.images.products.shoe01.image(
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           const SizedBox(width: 10),
              //           Expanded(
              //             child: Assets.images.products.shoe02.image(
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 10),
              //       Row(
              //         children: [
              //           SizedBox(
              //             width: 100,
              //             child: Assets.images.products.shoe03.image(
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
