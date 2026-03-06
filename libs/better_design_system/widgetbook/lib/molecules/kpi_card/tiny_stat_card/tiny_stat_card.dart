import 'package:better_design_system/molecules/kpi_card/tiny_stat_card/tiny_stat_card.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppTinyStatCard)
Widget defaultAppTinyStatCard(BuildContext context) {
  return AppTinyStatCard(
    title: context.knobs.title,
    icon: context.knobs.icon,
    iconColor: context.knobs.semanticColor,
  );
}
