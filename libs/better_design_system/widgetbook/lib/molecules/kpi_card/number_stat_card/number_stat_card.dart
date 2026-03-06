import 'package:better_design_system/molecules/kpi_card/number_stat_card/number_stat_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNumberStatCard)
Widget defaultAppNumberStatCard(BuildContext context) {
  final showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return SizedBox(
    width: 485,
    child: AppNumberStatCard(
      badgeTitle: showBadge ? 'Badge' : null,
      title: context.knobs.title,
      onMenuPressed: () {},
      onSeeMorePressed: () {},
      icon: context.knobs.icon,
      totalNumber: '1,000,000',
      percent: 23,
      style: context.knobs.object.dropdown(
        label: 'Style',
        options: NumberStatCardStyle.values,
        labelBuilder: (value) => value.name,
      ),
      options: [
        NumberStatCardOption(
          title: 'title',
          color: context.colors.warning,
          value: 30,
          subtitle: 'subtitle',
          percent: 23,
        ),
        NumberStatCardOption(
          title: 'title',
          color: context.colors.success,
          value: 50,
          subtitle: 'subtitle',
          percent: 23,
        ),
        NumberStatCardOption(
          title: 'title',
          color: context.colors.error,
          value: 80,
          subtitle: 'subtitle',
          percent: -23,
        ),
      ],
    ),
  );
}
