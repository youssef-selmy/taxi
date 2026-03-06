import 'package:better_design_system/molecules/kpi_card/small_percentage_stat_card/small_percentage_stat_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSmallPercentageStatCard)
Widget defaultAppSmallPercentageStatCard(BuildContext context) {
  final showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppSmallPercentageStatCard(
    badgeTitle: showBadge ? 'Badge' : null,
    title: context.knobs.title,
    subtitle: '1,000,000',
    percent: context.knobs.double.slider(
      label: 'Precent',
      initialValue: 20,
      min: -100,
      max: 100,
    ),
    number: 10,

    // icon: context.knobs.icon,
    trailing: Text(
      '20%',
      style: context.textTheme.labelLarge?.copyWith(
        color: context.colors.primary,
      ),
    ),
  );
}
