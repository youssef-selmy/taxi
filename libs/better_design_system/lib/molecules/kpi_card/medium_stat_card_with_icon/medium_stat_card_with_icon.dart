import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/widgets.dart';

typedef BetterMediumStatCardWithIcon = AppMediumStatCardWithIcon;

class AppMediumStatCardWithIcon extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String number;
  final String? badgeTitle;
  final double? percent;

  const AppMediumStatCardWithIcon({
    super.key,
    required this.title,
    required this.number,
    required this.icon,
    this.subtitle,
    this.badgeTitle,
    this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 360),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.primaryContainer,
                ),
                child: Icon(icon, color: context.colors.primary, size: 20),
              ),

              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: <Widget>[
                  Text(
                    title,
                    style: context.textTheme.labelLarge?.variant(context),
                  ),
                  if (badgeTitle != null)
                    AppBadge(
                      text: badgeTitle!,
                      color: SemanticColor.warning,
                      isRounded: true,
                    ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4,
            children: [
              Text(number, style: context.textTheme.headlineSmall),
              if (subtitle != null || percent != null)
                Row(
                  spacing: 4,
                  children: [
                    if (percent != null)
                      AppBadge(
                        prefixIcon: percent! > 0
                            ? BetterIcons.chartUpFilled
                            : BetterIcons.chartDownFilled,
                        text: '${percent?.toStringAsFixed(1)}%',
                        color: percent! > 0
                            ? SemanticColor.success
                            : SemanticColor.error,
                        isRounded: true,
                      ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.textTheme.labelSmall?.variant(context),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
