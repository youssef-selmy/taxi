import 'package:better_design_system/molecules/kpi_card/medium_stat_card_with_icon/medium_stat_card_with_icon.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppMediumStatCardWithIcon)
Widget defaultAppMediumStatCardWithIcon(BuildContext context) {
  final showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppMediumStatCardWithIcon(
    badgeTitle: showBadge ? 'Badge' : null,
    title: context.knobs.title,
    subtitle: 'Subtitle',
    percent: context.knobs.double.slider(
      label: 'Precent',
      initialValue: 20,
      min: -100,
      max: 100,
    ),
    number: '1,000,000',
    icon: context.knobs.icon,
  );
}
