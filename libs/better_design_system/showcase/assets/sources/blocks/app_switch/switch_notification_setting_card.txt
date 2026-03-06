import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class SwitchNotificationSettingCard extends StatefulWidget {
  const SwitchNotificationSettingCard({super.key});

  @override
  State<SwitchNotificationSettingCard> createState() =>
      _SwitchNotificationSettingCardState();
}

class _SwitchNotificationSettingCardState
    extends State<SwitchNotificationSettingCard> {
  List<String> selecteditems = ['Email Alerts', 'Push Notifications'];

  void _onItemSelected(String value) {
    if (selecteditems.contains(value)) {
      setState(() {
        selecteditems.removeWhere((element) => element == value);
      });
    } else {
      setState(() {
        selecteditems.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 405,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              spacing: 12,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.surface,
                    border: Border.all(color: context.colors.outline),
                  ),
                  child: Icon(
                    BetterIcons.notification02Outline,
                    size: 24,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Notification Setting',
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      'Control how and when you get notified',
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),
              ],
            ),
            AppDivider(height: 36),
            Column(
              spacing: 24,
              children: [
                _buildNotificationItem(
                  context,
                  icon: BetterIcons.mail02Filled,
                  iconColor: SemanticColor.insight,
                  title: 'Email Alerts',
                  subtitle: 'Get notified by email about updates or mentions',
                  isSelected: selecteditems.contains('Email Alerts'),
                  onChanged: (_) {
                    _onItemSelected('Email Alerts');
                  },
                ),
                _buildNotificationItem(
                  context,
                  icon: BetterIcons.notification02Filled,
                  iconColor: SemanticColor.error,
                  title: 'Push Notifications',
                  subtitle: 'Receive instant push notifications on your device',
                  isSelected: selecteditems.contains('Push Notifications'),
                  onChanged: (_) {
                    _onItemSelected('Push Notifications');
                  },
                ),
                _buildNotificationItem(
                  context,
                  icon: BetterIcons.calendar01Filled,
                  iconColor: SemanticColor.info,
                  title: 'Weekly Summary',
                  subtitle: 'Get a summary of your activity once a week',
                  isSelected: selecteditems.contains('Weekly Summary'),
                  onChanged: (_) {
                    _onItemSelected('Weekly Summary');
                  },
                ),
                _buildNotificationItem(
                  context,
                  icon: BetterIcons.moon02Filled,
                  iconColor: SemanticColor.warning,
                  title: 'Do Not Disturb',
                  isSelected: selecteditems.contains('Do Not Disturb'),
                  onChanged: (_) {
                    _onItemSelected('Do Not Disturb');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required IconData icon,
    required SemanticColor iconColor,
    required String title,
    String? subtitle,
    required bool isSelected,
    void Function(bool)? onChanged,
  }) => Row(
    crossAxisAlignment:
        subtitle == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    spacing: 8,
    children: [
      Row(
        spacing: 12,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: iconColor.containerColor(context),
            ),
            child: Icon(icon, size: 20, color: iconColor.main(context)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(title, style: context.textTheme.titleSmall),
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
        ],
      ),
      AppSwitch(isSelected: isSelected, onChanged: onChanged),
    ],
  );
}
