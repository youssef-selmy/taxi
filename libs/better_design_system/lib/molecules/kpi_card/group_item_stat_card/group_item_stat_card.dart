import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/molecules/kpi_card/group_item_stat_card/group_item_stat_card_option.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
export 'group_item_stat_card_option.dart';

typedef BetterGroupItemStatCard = AppGroupItemStatCard;

class AppGroupItemStatCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? badgeTitle;
  final List<GroupItemStatCardOption> option;
  final double width;
  final bool hasDot;
  const AppGroupItemStatCard({
    super.key,
    required this.title,
    this.icon,
    this.badgeTitle,
    this.width = 280,
    required this.option,
    this.hasDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const SizedBox(height: 24),

          ...option
              .map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (hasDot)
                          Container(
                            decoration: BoxDecoration(
                              color: e.color,
                              shape: BoxShape.circle,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        if (e.icon != null && !hasDot)
                          Icon(e.icon, size: 20, color: e.color),
                        if (hasDot || e.icon != null) const SizedBox(width: 8),
                        Text(
                          e.title,
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${e.percent.toStringAsFixed(1)}%',
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              )
              .toList()
              .separated(separator: const SizedBox(height: 16)),
        ],
      ),
    );
  }
}
