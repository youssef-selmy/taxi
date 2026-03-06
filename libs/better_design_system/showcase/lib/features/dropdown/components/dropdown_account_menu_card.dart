import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

/// A dropdown card displaying user account information and navigation menu.
///
/// This component shows a user avatar, profile information, and a list of
/// navigation items organized into groups separated by dividers.
class DropdownAccountMenuCard extends StatelessWidget {
  const DropdownAccountMenuCard({super.key});

  /// Navigation items configuration with icons.
  ///
  /// The list contains tuples of (title, outlineIcon, filledIcon).
  static const _navigationItems = [
    // Profile Section (indices 0-2)
    ('View Profile', BetterIcons.userOutline, BetterIcons.userFilled),
    ('Settings', BetterIcons.settings01Outline, BetterIcons.settings01Filled),
    (
      'Subscription',
      BetterIcons.creditCardOutline,
      BetterIcons.creditCardFilled,
    ),
    // Team Section (indices 3-5)
    ('Changelog', BetterIcons.clock01Outline, BetterIcons.clock01Filled),
    ('Team', BetterIcons.userGroup02Outline, BetterIcons.userGroup03Filled),
    ('Invite', BetterIcons.userAdd01Outline, BetterIcons.userAdd01Filled),
    // Support Section (indices 6-7)
    ('Support', BetterIcons.headphonesOutline, BetterIcons.headphonesFilled),
    ('Community', BetterIcons.chatting01Outline, BetterIcons.chatting01Filled),
    // Logout Section (index 8)
    ('Logout', BetterIcons.logout01Outline, BetterIcons.logout01Filled),
  ];

  /// Indices where dividers should appear after the item.
  ///
  /// Dividers are placed after indices 2, 5, and 7 to create visual groups:
  /// - After "Subscription" (index 2)
  /// - After "Invite" (index 5)
  /// - After "Community" (index 7)
  static const _dividerIndices = {2, 5, 7};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 326,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildUserProfile(context),
            const AppDivider(height: 20),
            _buildNavigationItems(),
          ],
        ),
      ),
    );
  }

  /// Builds the user profile section with avatar and information.
  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        spacing: 8,
        children: [
          AppAvatar(
            imageUrl: ImageFaker().person.three,
            size: AvatarSize.size40px,
            statusBadgeType: StatusBadgeType.online,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text('Charlie Press', style: context.textTheme.labelLarge),
              Text(
                'charlie@better.com',
                style: context.textTheme.bodySmall?.variant(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the navigation items list with dividers.
  ///
  /// Maps through [_navigationItems] and inserts dividers at [_dividerIndices].
  Widget _buildNavigationItems() {
    return Column(
      spacing: 4,
      children: [
        for (var i = 0; i < _navigationItems.length; i++) ...[
          _buildNavigationItem(_navigationItems[i]),
          if (_dividerIndices.contains(i)) const AppDivider(height: 12),
        ],
      ],
    );
  }

  /// Builds a single navigation item.
  Widget _buildNavigationItem((String, IconData, IconData) itemData) {
    final (title, outlineIcon, filledIcon) = itemData;

    return AppSidebarNavigationItem(
      item: NavigationItem(
        title: title,
        value: title,
        icon: (outlineIcon, filledIcon),
        subItems: [NavigationSubItem(title: 'title', value: 'value')],
      ),
      selectedItem: null,
      onItemSelected: (_) {},
    );
  }
}
