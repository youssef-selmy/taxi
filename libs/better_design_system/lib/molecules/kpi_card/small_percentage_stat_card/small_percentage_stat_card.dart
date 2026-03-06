import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/percent_badge/percent_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

typedef BetterSmallPercentageStatCard = AppSmallPercentageStatCard;

class AppSmallPercentageStatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badgeTitle;
  final double? percent;
  final IconData? icon;
  final int number;

  final Widget? trailing;
  const AppSmallPercentageStatCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.badgeTitle,
    this.percent,
    this.trailing,
    this.icon,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryContainer,
            ),
            child: icon != null
                ? Icon(icon, color: context.colors.primary)
                : Text(
                    number.toString(),
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: <Widget>[
              Row(
                spacing: 4,
                children: <Widget>[
                  Text(
                    title,
                    style: context.textTheme.labelLarge?.variant(context),
                  ),
                  if (badgeTitle != null)
                    const AppBadge(
                      text: 'Badge',
                      color: SemanticColor.warning,
                      isRounded: true,
                    ),
                ],
              ),
              Row(
                spacing: 4,
                children: <Widget>[
                  Text(
                    subtitle,
                    style: context.textTheme.labelSmall?.variant(context),
                  ),
                  if (percent != null) AppPercentBadge(percent: percent!),
                ],
              ),
            ],
          ),

          if (trailing != null) ...[const SizedBox(width: 20), trailing!],
        ],
      ),
    );
  }
}
