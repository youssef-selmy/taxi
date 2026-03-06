import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/top_bar_icon_button.dart';
import 'package:better_design_system/atoms/navbar/navbar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class HrPlatformMobileTopBar extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final List<IconData> suffixIcons;
  final TextStyle? Function(BuildContext) titleStyle;

  const HrPlatformMobileTopBar._({
    required this.prefixIcon,
    required this.title,
    required this.suffixIcons,
    required this.titleStyle,
  });

  /// Style1 top bar with search, notifications, and store icons.
  factory HrPlatformMobileTopBar.style1({
    required String title,
    required IconData prefixIcon,
  }) {
    return HrPlatformMobileTopBar._(
      prefixIcon: prefixIcon,
      title: title,
      suffixIcons: const [
        BetterIcons.calendar03Outline,
        BetterIcons.search01Filled,
        BetterIcons.notification02Outline,
      ],
      titleStyle: (context) => context.textTheme.titleSmall,
    );
  }

  /// Style2 top bar with custom suffix icons.
  factory HrPlatformMobileTopBar.style2({
    required String title,
    required IconData prefixIcon,
    required List<IconData> suffixIcons,
  }) {
    return HrPlatformMobileTopBar._(
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
            (icon) => AppOutlinedButton(
              onPressed: () {},
              prefixIcon: icon,
              color: SemanticColor.neutral,
              size: ButtonSize.medium,
              borderRadius: BorderRadius.circular(8),
              foregroundColor: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
