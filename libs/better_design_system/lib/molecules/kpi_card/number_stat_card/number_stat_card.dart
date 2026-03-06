import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/menu_button.dart';
import 'package:better_design_system/atoms/buttons/see_more_button.dart';
import 'package:better_design_system/atoms/percent_badge/percent_badge.dart';
import 'package:better_design_system/molecules/kpi_card/number_stat_card/number_stat_card_option.dart';
import 'package:better_design_system/molecules/kpi_card/number_stat_card/number_stat_card_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
export 'number_stat_card_style.dart';
export 'number_stat_card_option.dart';

typedef BetterNumberStatCard = AppNumberStatCard;

class AppNumberStatCard extends StatelessWidget {
  final String title;
  final String? totalNumber;
  final IconData? icon;
  final String? badgeTitle;
  final double? percent;
  final void Function()? onMenuPressed;
  final void Function()? onSeeMorePressed;
  final List<NumberStatCardOption> options;
  final NumberStatCardStyle style;
  const AppNumberStatCard({
    super.key,
    required this.title,
    this.icon,
    this.badgeTitle,
    this.onMenuPressed,
    this.onSeeMorePressed,
    required this.options,
    this.totalNumber,
    this.percent,
    this.style = NumberStatCardStyle.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
        top: onMenuPressed != null
            ? 7
            : onSeeMorePressed != null
            ? 14
            : 16,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
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
              if (onSeeMorePressed != null || onMenuPressed != null)
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
          if (totalNumber != null || percent != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                if (totalNumber != null)
                  Text(totalNumber!, style: context.textTheme.headlineSmall),

                if (percent != null) AppPercentBadge(percent: percent!),
              ],
            ),
          ],
          const SizedBox(height: 20),

          Row(
            children: options
                .map(
                  (e) => Expanded(
                    flex: e.value.round(),
                    child: Container(
                      height: 9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: e.color,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: style == NumberStatCardStyle.horizontal ? 24 : 20),

          switch (style) {
            NumberStatCardStyle.compact => _getCompactStyle(context),
            NumberStatCardStyle.vertical => _getVerticalStyle(context),
            NumberStatCardStyle.horizontal => _getHorizontalStyle(context),
          },
        ],
      ),
    );
  }

  Widget _getDot(Color color, {double size = 8}) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: size,
      height: size,
    );
  }

  Widget _getCompactStyle(BuildContext context) {
    return Row(
      children: <Widget>[
        ...options
            .map(
              (e) => Row(
                spacing: 6,
                children: [
                  _getDot(e.color),
                  Text(e.title, style: context.textTheme.labelMedium),
                ],
              ),
            )
            .toList()
            .separated(separator: const SizedBox(width: 24)),
      ],
    );
  }

  Widget _getVerticalStyle(BuildContext context) {
    return Column(
      children: <Widget>[
        ...options
            .map(
              (e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    spacing: 6,
                    children: [
                      _getDot(e.color),
                      Text(
                        e.value.toString(),
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  if (e.subtitle != null)
                    Text(
                      e.subtitle!,
                      style: context.textTheme.labelSmall?.variant(context),
                    ),
                ],
              ),
            )
            .toList()
            .separated(separator: const SizedBox(height: 12)),
      ],
    );
  }

  Widget _getHorizontalStyle(BuildContext context) {
    return Row(
      children: <Widget>[
        ...options
            .map(
              (e) => Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        _getDot(e.color, size: 12),
                        Text(
                          e.title,
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      spacing: 4,
                      children: <Widget>[
                        Text(
                          e.value.toString(),
                          style: context.textTheme.headlineSmall,
                        ),
                        if (e.percent != null)
                          AppPercentBadge(percent: e.percent!),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList()
            .separated(
              separator: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  width: 1,
                  color: context.colors.outline,
                  height: 56,
                ),
              ),
            ),
      ],
    );
  }
}
