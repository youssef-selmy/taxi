import 'package:better_design_system/molecules/kpi_card/small_stat_card/small_stat_card.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSmallStatCard)
Widget defaultAppSmallStatCard(BuildContext context) {
  final showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppSmallStatCard(
    badgeTitle: showBadge ? 'Badge' : null,
    title: context.knobs.title,
    subtitle: '1,000,000',
    showBackground: context.knobs.boolean(
      label: 'Show Background',
      initialValue: true,
    ),
    percent: context.knobs.double.slider(
      label: 'Precent',
      initialValue: 20,
      min: -100,
      max: 100,
    ),
    icon: context.knobs.icon,
  );
}
