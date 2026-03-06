import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class BadgeNotificationPanelCard extends StatelessWidget {
  const BadgeNotificationPanelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 273,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildItem(
              context,
              icon: BetterIcons.notification02Outline,
              title: 'Notification',
              badgeText: '4 Notifications',
              badgeColor: SemanticColor.error,
            ),
            AppDivider(height: 20),
            _buildItem(
              context,
              icon: BetterIcons.message01Outline,
              title: 'Message',
              badgeText: '+9 Message',
              badgeColor: SemanticColor.primary,
            ),
            AppDivider(height: 20),
            _buildItem(
              context,
              icon: BetterIcons.headphonesOutline,
              title: 'Support',
              badgeText: '4 Requests',
              badgeColor: SemanticColor.primary,
            ),
            AppDivider(height: 20),
            _buildItem(
              context,
              icon: BetterIcons.settings01Outline,
              title: 'Settings',
              badgeText: '5 Updates',
              badgeColor: SemanticColor.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String badgeText,
    required SemanticColor badgeColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: <Widget>[
        Row(
          spacing: 8,
          children: [
            Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
            Text(title, style: context.textTheme.labelLarge),
          ],
        ),
        AppBadge(text: badgeText, color: badgeColor, size: BadgeSize.large),
      ],
    );
  }
}
