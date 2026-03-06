import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class RadioShareSettingCard extends StatefulWidget {
  const RadioShareSettingCard({super.key});

  @override
  State<RadioShareSettingCard> createState() => _RadioShareSettingCardState();
}

class _RadioShareSettingCardState extends State<RadioShareSettingCard> {
  String selectedShareSetting = 'Private';

  void _onShareSettingChanged(String value) {
    setState(() {
      selectedShareSetting = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  spacing: 16,
                  children: [
                    Icon(
                      BetterIcons.share08Outline,
                      size: 24,
                      color: context.colors.onSurfaceVariant,
                    ),
                    Text('Share Setting', style: context.textTheme.labelLarge),
                  ],
                ),
                Icon(
                  BetterIcons.cancelCircleOutline,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              spacing: 16,
              children: [
                _buildSettingItem(
                  context,
                  title: 'Private',
                  subtitle: 'This file is only accessible by you',
                  onChanged: _onShareSettingChanged,
                ),
                _buildSettingItem(
                  context,
                  title: 'Restricted (Invite-only-access)',
                  subtitle: 'Share with specific people by email',
                  onChanged: _onShareSettingChanged,
                ),
                _buildSettingItem(
                  context,
                  title: 'Team-wide',
                  subtitle: 'Anyone in your team workspace can view this file',
                  onChanged: _onShareSettingChanged,
                ),
                _buildSettingItem(
                  context,
                  title: 'Public Link',
                  onChanged: _onShareSettingChanged,
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
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
                    text: 'Save Changes',
                    color: SemanticColor.neutral,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String title,
    String? subtitle,
    void Function(String)? onChanged,
  }) => Row(
    crossAxisAlignment:
        subtitle == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    spacing: 8,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(title, style: context.textTheme.labelLarge),
          if (subtitle != null)
            SizedBox(
              width: 268,
              child: Text(
                subtitle,
                style: context.textTheme.bodySmall?.variant(context),
                maxLines: 2,
              ),
            ),
        ],
      ),
      AppRadio(
        value: title,
        onTap: onChanged,
        groupValue: selectedShareSetting,
      ),
    ],
  );
}
