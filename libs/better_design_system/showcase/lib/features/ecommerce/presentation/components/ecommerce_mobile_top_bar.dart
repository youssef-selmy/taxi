import 'package:better_design_system/atoms/buttons/top_bar_icon_button.dart';
import 'package:better_design_system/atoms/navbar/navbar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

/// A mobile-optimized top bar for e-commerce applications.
///
/// The [EcommerceMobileTopBar] provides a consistent navigation bar for mobile
/// e-commerce screens with a prefix icon, title, and customizable suffix icons.
///
/// Example:
/// ```dart
/// EcommerceMobileTopBar.dashboardPanel(
///   title: 'Dashboard',
///   prefixIcon: BetterIcons.menu01Outline,
/// )
/// ```
class EcommerceMobileTopBar extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final List<IconData> suffixIcons;
  final TextStyle? Function(BuildContext) titleStyle;

  const EcommerceMobileTopBar._({
    required this.prefixIcon,
    required this.title,
    required this.suffixIcons,
    required this.titleStyle,
  });

  /// Dashboard panel top bar with search, notifications, and store icons.
  factory EcommerceMobileTopBar.dashboardPanel({
    required String title,
    required IconData prefixIcon,
  }) {
    return EcommerceMobileTopBar._(
      prefixIcon: prefixIcon,
      title: title,
      suffixIcons: const [
        BetterIcons.search01Filled,
        BetterIcons.notification02Outline,
        BetterIcons.store01Outline,
      ],
      titleStyle: (context) => context.textTheme.titleSmall,
    );
  }

  /// Client side top bar with custom suffix icons.
  factory EcommerceMobileTopBar.clientSide({
    required String title,
    required IconData prefixIcon,
    required List<IconData> suffixIcons,
  }) {
    return EcommerceMobileTopBar._(
      prefixIcon: prefixIcon,
      title: title,
      suffixIcons: suffixIcons,
      titleStyle: (context) => context.textTheme.labelLarge,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppNavbar(
      showDivider: false,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      prefix: Row(
        spacing: 8,
        children: [
          AppTopBarIconButton(
            icon: prefixIcon,
            iconColor: context.colors.onSurfaceVariant,
          ),
          Text(title, style: titleStyle(context)),
        ],
      ),
      suffix: Row(
        spacing: 8,
        children: [
          const SizedBox(width: 8),
          ...suffixIcons.map(
            (icon) => AppTopBarIconButton(
              icon: icon,
              iconColor: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
