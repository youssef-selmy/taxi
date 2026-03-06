import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/kpi_card/large_stat_card/large_stat_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLargeStatCard)
Widget defaultAppLargeStatCard(BuildContext context) {
  final showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppLargeStatCard(
    onMenuPressed: () {},
    badgeTitle: showBadge ? 'Badge' : null,
    title: context.knobs.title,
    subtitle: 'Subtitle',
    number: '1,000,000',
    icon: context.knobs.icon,
    trailing: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.primaryContainer,
      ),
      child: Icon(
        BetterIcons.coins01Filled,
        color: context.colors.primary,
        size: 24,
      ),
    ),
    onSeeMorePressed: () {},
  );
}
