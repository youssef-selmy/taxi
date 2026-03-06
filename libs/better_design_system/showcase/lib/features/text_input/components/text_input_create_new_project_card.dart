import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextInputCreateNewProjectCard extends StatefulWidget {
  const TextInputCreateNewProjectCard({super.key});

  @override
  State<TextInputCreateNewProjectCard> createState() =>
      _TextInputCreateNewProjectCardState();
}

class _TextInputCreateNewProjectCardState
    extends State<TextInputCreateNewProjectCard> {
  String _selectedPrivacy = 'private';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              bottom: 14,
              right: 8,
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Create New Project', style: context.textTheme.labelLarge),
                AppIconButton(
                  icon: BetterIcons.cancelCircleOutline,
                  onPressed: () {},
                  iconColor: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: 'Project Name',
                  hint: 'Enter project name',
                  isFilled: false,
                ),
                Column(
                  children: [
                    AppTextField(
                      label: 'Invite Users',
                      hint: 'Search users',
                      isFilled: false,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      spacing: 8,
                      children: [
                        AppTag(
                          text: 'Kadin Herwitz',
                          style: TagStyle.outline,
                          color: SemanticColor.neutral,
                          size: TagSize.medium,
                          prefixWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Assets.images.avatars.illustration01.image(
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                          ),
                          suffixWidget: Icon(
                            BetterIcons.cancel01Outline,
                            size: 18,
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        AppTag(
                          text: 'Talan Kenter',
                          style: TagStyle.outline,
                          color: SemanticColor.neutral,
                          size: TagSize.medium,
                          prefixWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Assets.images.avatars.illustration02.image(
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                          ),
                          suffixWidget: Icon(
                            BetterIcons.cancel01Outline,
                            size: 18,
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        AppTag(
                          text: 'Justin Mango',
                          style: TagStyle.outline,
                          color: SemanticColor.neutral,
                          size: TagSize.medium,
                          prefixWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Assets.images.avatars.illustration03.image(
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                          ),
                          suffixWidget: Icon(
                            BetterIcons.cancel01Outline,
                            size: 18,
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: AppRadio(
                            value: 'private',
                            groupValue: _selectedPrivacy,
                            onTap: (value) {
                              setState(() {
                                _selectedPrivacy = value;
                              });
                            },
                            size: RadioSize.medium,
                          ),
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Private',
                              style: context.textTheme.labelLarge,
                            ),
                            Text(
                              'Only invited people can see and edit',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: AppRadio(
                            value: 'public',
                            groupValue: _selectedPrivacy,
                            onTap: (value) {
                              setState(() {
                                _selectedPrivacy = value;
                              });
                            },
                            size: RadioSize.medium,
                          ),
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Public', style: context.textTheme.labelLarge),
                            Text(
                              'All people can view and join to this project',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 2,
                          children: [
                            Text(
                              'Upload File',
                              style: context.textTheme.labelLarge,
                            ),
                            Icon(
                              BetterIcons.alertCircleFilled,
                              size: 12,
                              color: context.colors.onSurfaceVariantLow,
                            ),
                          ],
                        ),
                        Text(
                          'Add file to this project',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                      ],
                    ),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Add',
                      color: SemanticColor.neutral,
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
                  child: AppFilledButton(onPressed: () {}, text: 'Create'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
