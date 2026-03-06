import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/molecules/file_upload/file_upload.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ModalUserDetails extends StatelessWidget {
  const ModalUserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 496,
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
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(BetterIcons.userCircle02Filled, size: 24),
                ),
                const SizedBox(width: 16),
                Text('User Details', style: context.textTheme.labelLarge),
                const Spacer(),
                AppIconButton(
                  icon: BetterIcons.cancelCircleOutline,
                  iconColor: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: Assets.images.avatars.illustration01.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Copy link',
                      color: SemanticColor.neutral,
                      prefix: Icon(BetterIcons.link04Outline, size: 20),
                    ),
                    const SizedBox(width: 8),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'View profile',
                      color: SemanticColor.neutral,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Carter Botosh', style: context.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  'carter@better.com',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.5),
                  child: const AppDivider(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: context.textTheme.labelLarge),
                    const Spacer(),
                    AppTextField(
                      constraints: BoxConstraints(maxWidth: 137.5),
                      isFilled: false,
                      density: TextFieldDensity.dense,
                      initialValue: 'Carter',
                    ),
                    const SizedBox(width: 8),
                    AppTextField(
                      constraints: BoxConstraints(maxWidth: 137.5),
                      isFilled: false,
                      density: TextFieldDensity.dense,
                      initialValue: 'Botosh',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.5),
                  child: const AppDivider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: context.textTheme.labelLarge),
                    AppTextField(
                      constraints: BoxConstraints(maxWidth: 283),
                      isFilled: false,
                      density: TextFieldDensity.dense,
                      initialValue: 'carter@better.com',
                      prefixIcon: Icon(
                        BetterIcons.mail02Outline,
                        size: 20,
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.5),
                  child: const AppDivider(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username', style: context.textTheme.labelLarge),
                    const Spacer(),
                    AppTextField(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.zero,
                      ),
                      isDisabled: true,
                      constraints: BoxConstraints(maxWidth: 100),
                      isFilled: false,
                      density: TextFieldDensity.dense,
                      initialValue: 'better.com/',
                    ),
                    AppTextField(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(8),
                      ),
                      isDisabled: true,
                      constraints: BoxConstraints(maxWidth: 187),
                      isFilled: false,
                      density: TextFieldDensity.dense,
                      initialValue: 'Carter',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.5),
                  child: const AppDivider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile photo', style: context.textTheme.labelLarge),
                    AppFileUpload<String>(
                      style: UploadFieldStyle.horizontal,
                      imageUrlGetter: (url) => url,
                      initialValue: 'https://picsum.photos/200',
                      onUpload: (path, bytes) async {
                        // Simulate upload
                        await Future.delayed(const Duration(seconds: 1));
                        return ApiResponse.loaded('https://picsum.photos/200');
                      },
                      onDelete: (url) {
                        // Handle delete
                        return true;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 12,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Cancel',
                    color: SemanticColor.neutral,
                  ),
                ),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Save changes',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
