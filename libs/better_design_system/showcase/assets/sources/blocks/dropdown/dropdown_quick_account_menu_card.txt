import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

/// A quick dropdown card displaying user account information with essential menu items.
///
/// This component shows a user avatar, profile information, and a compact list of
/// essential navigation items: Your Shop, Documentation, Affiliate, Settings, and Logout.
class DropdownQuickAccountMenuCard extends StatefulWidget {
  const DropdownQuickAccountMenuCard({super.key});

  /// Navigation items configuration with icons.
  ///
  /// The list contains tuples of (title, outlineIcon, filledIcon).

  @override
  State<DropdownQuickAccountMenuCard> createState() =>
      _DropdownQuickAccountMenuCardState();
}

class _DropdownQuickAccountMenuCardState
    extends State<DropdownQuickAccountMenuCard> {
  String selectedTheme = 'light';
  void _onThemeChanged(String value) {
    setState(() {
      selectedTheme = value;
    });
  }

  static const _navigationItems = [
    // Main Section (indices 0-3)
    ('Your Shop', BetterIcons.store01Outline, BetterIcons.store01Filled),
    ('Documentation', BetterIcons.folder03Outline, BetterIcons.folder03Filled),
    ('Affiliate', BetterIcons.share07Outline, BetterIcons.share07Filled),
    ('Settings', BetterIcons.settings01Outline, BetterIcons.settings01Filled),
    // Logout Section (index 4)
    ('Logout', BetterIcons.logout01Outline, BetterIcons.logout01Filled),
  ];

  /// Indices where dividers should appear after the item.
  ///
  /// Divider is placed after index 3 (Settings) to separate logout action.
  static const _dividerIndices = {3};

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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Free Plan', style: context.textTheme.labelLarge),
                  AppSoftButton(
                    onPressed: () {},
                    text: 'Upgrade',
                    size: ButtonSize.medium,
                  ),
                ],
              ),
            ),
            const AppDivider(height: 20),
            AppToggleSwitchButtonGroup<String>(
              isExpanded: true,
              options: [
                ToggleSwitchButtonGroupOption(
                  value: 'light',
                  icon: BetterIcons.sun02Outline,
                  selectedIcon: BetterIcons.sun01Filled,
                ),
                ToggleSwitchButtonGroupOption(
                  value: 'dark',
                  icon: BetterIcons.moon02Outline,
                  selectedIcon: BetterIcons.moon02Filled,
                ),

                ToggleSwitchButtonGroupOption(
                  value: 'system',
                  icon: BetterIcons.computerOutline,
                  selectedIcon: BetterIcons.computerFilled,
                ),
              ],
              onChanged: _onThemeChanged,
              selectedValue: selectedTheme,
            ),
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
  /// Maps through [DropdownQuickAccountMenuCard._navigationItems] and inserts dividers at [DropdownQuickAccountMenuCard._dividerIndices].
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
