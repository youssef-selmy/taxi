import 'dart:ui';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'drawer_item.dart';

export 'drawer_item.dart';

typedef BetterDrawer = AppDrawer;

class AppDrawer<T> extends StatelessWidget {
  final List<AppDrawerItem<T>> items;
  final String? profileImageUrl;
  final String? fullName;
  final String? mobileNumber;
  final T selectedValue;
  final Function(T?)? onItemSelected;
  final Function()? onLogoutPressed;
  final bool showLogout;

  const AppDrawer({
    super.key,
    this.items = const [],
    this.profileImageUrl,
    this.fullName,
    this.mobileNumber,
    required this.selectedValue,
    this.onItemSelected,
    this.onLogoutPressed,
    this.showLogout = true,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
        width: 300,
        decoration: BoxDecoration(color: context.colors.surface),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 56,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(color: context.colors.surfaceVariant),
              child: SafeArea(
                bottom: false,
                right: false,
                child: Row(
                  children: [
                    AppAvatar(
                      imageUrl: profileImageUrl,
                      shape: AvatarShape.circle,
                      size: AvatarSize.size40px,
                    ),
                    const SizedBox(width: 12),
                    if (fullName != null && mobileNumber != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          if (fullName?.isNotEmpty ?? false)
                            Text(
                              fullName!,
                              style: context.textTheme.labelLarge,
                            ),
                          Text(
                            mobileNumber!,
                            style: context.textTheme.bodySmall?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  children: [
                    for (final item in items)
                      AppSidebarNavigationItem<T>(
                        item: NavigationItem(
                          title: item.title,
                          value: item.value,
                          icon: (item.icon, item.icon),
                        ),
                        onItemSelected: (p0) => onItemSelected?.call(p0),
                        selectedItem: selectedValue,
                      ),
                  ],
                ),
              ),
            ),
            if (showLogout)
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppDivider(height: 10),
                      AppSidebarNavigationItem(
                        item: NavigationItem(
                          icon: (
                            BetterIcons.logout01Outline,
                            BetterIcons.logout01Outline,
                          ),
                          title: context.strings.logout,
                          value: 0,
                        ),
                        onItemSelected: (p0) => onLogoutPressed?.call(),
                        selectedItem: selectedValue,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
