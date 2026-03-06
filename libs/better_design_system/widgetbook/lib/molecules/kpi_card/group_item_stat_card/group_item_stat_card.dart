import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/kpi_card/group_item_stat_card/group_item_stat_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppGroupItemStatCard)
Widget defaultAppGroupItemStatCard(BuildContext context) {
  final showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppGroupItemStatCard(
    badgeTitle: showBadge ? 'Badge' : null,
    title: context.knobs.title,
    hasDot: context.knobs.boolean(
      label: 'Has Dot',
      initialValue: false,
      description: 'Hide icons and show a single dot instead when true',
    ),
    icon: context.knobs.icon,
    option: [
      GroupItemStatCardOption(
        context.colors.error,
        title: 'title',
        percent: 23,
        icon: BetterIcons.coupon01Filled,
      ),
      GroupItemStatCardOption(
        context.colors.success,
        title: 'title',
        percent: 45,
        icon: BetterIcons.coupon01Filled,
      ),
      GroupItemStatCardOption(
        context.colors.warning,
        title: 'title',
        percent: 45,
        icon: BetterIcons.coupon01Filled,
      ),
      GroupItemStatCardOption(
        context.colors.primary,
        title: 'title',
        percent: 13,
        icon: BetterIcons.coupon01Filled,
      ),
    ],
  );
}
