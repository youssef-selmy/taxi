import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/percent_badge/percent_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

typedef BetterSmallStatCard = AppSmallStatCard;

class AppSmallStatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badgeTitle;
  final double? percent;
  final IconData icon;
  final bool showBackground;
  const AppSmallStatCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.badgeTitle,
    this.percent,
    this.showBackground = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: showBackground ? const EdgeInsets.all(16) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: showBackground
            ? Border.all(width: 1, color: context.colors.outline)
            : null,
        boxShadow: showBackground
            ? [
                BoxShadow(
                  color: context.colors.shadow,
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ]
            : [],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: showBackground
                  ? context.colors.primaryContainer
                  : context.colors.primary,
            ),
            child: Icon(
              icon,
              color: showBackground
                  ? context.colors.primary
                  : context.colors.onPrimary,
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
                  Text(subtitle, style: context.textTheme.titleSmall),
                  if (percent != null) AppPercentBadge(percent: percent!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
