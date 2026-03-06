import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/file_upload/file_upload.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FileUploadProfileImageCard extends StatelessWidget {
  const FileUploadProfileImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 443,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              bottom: 14,
              left: 20,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile Image', style: context.textTheme.labelLarge),
                AppIconButton(
                  icon: BetterIcons.cancelCircleOutline,
                  iconColor: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 61.5, vertical: 20),
            child: AppFileUpload<String>(
              initialValue: 'https://i.pravatar.cc/300?img=8',
              title: 'Upload image',
              subtitle: 'JPG or PNG, max 2MB',
              imageUrlGetter: (value) => value,
              onUpload: (value, bytes) async {
                // Simulate upload and return the uploaded URL
                await Future.delayed(const Duration(seconds: 2));
                return ApiResponse.loaded('https://i.pravatar.cc/300?img=12');
              },
              onDelete: (value) {
                // Handle delete
                return true;
              },
              style: UploadFieldStyle.horizontal,
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
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
                  child: AppFilledButton(onPressed: () {}, text: 'Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
