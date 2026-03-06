import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/menu_button.dart';
import 'package:better_design_system/atoms/buttons/see_more_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

typedef BetterLargeStatCard = AppLargeStatCard;

class AppLargeStatCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String number;
  final String? badgeTitle;
  final Widget? trailing;
  final void Function()? onMenuPressed;
  final void Function()? onSeeMorePressed;
  const AppLargeStatCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.number,
    this.badgeTitle,
    this.trailing,
    this.onMenuPressed,
    this.onSeeMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: context.colors.outline),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (icon != null) ...[
                    Icon(icon, color: context.colors.primary, size: 20),
                    const SizedBox(width: 8),
                  ],

                  Text(
                    title,
                    style: context.textTheme.labelLarge?.variant(context),
                  ),
                  if (badgeTitle != null) ...[
                    const SizedBox(width: 4),
                    AppBadge(
                      text: badgeTitle!,
                      color: SemanticColor.warning,
                      isRounded: true,
                    ),
                  ],
                ],
              ),
              Row(
                spacing: 8,
                children: <Widget>[
                  if (onSeeMorePressed != null)
                    AppSeeMoreButton(onPressed: onSeeMorePressed),
                  if (onMenuPressed != null)
                    AppMenuButton(onPressed: onMenuPressed),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(number, style: context.textTheme.headlineSmall),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: context.textTheme.labelSmall?.variant(context),
                    ),
                ],
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ],
      ),
    );
  }
}
