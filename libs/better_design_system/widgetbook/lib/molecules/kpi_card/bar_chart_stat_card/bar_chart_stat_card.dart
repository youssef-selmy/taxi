import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/molecules/kpi_card/bar_chart_stat_card/bar_chart_stat_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppBarChartStatCard)
Widget defaultAppBarChartStatCard(BuildContext context) {
  final List<ChartSeriesData> data = [
    ChartSeriesData(
      name: 'Taxi',
      points: [
        ChartPoint(name: 'Mon', value: 23),
        ChartPoint(name: 'Tue', value: 23),
        ChartPoint(name: 'Fri', value: 23),
      ],
      color: context.colors.error,
    ),
    ChartSeriesData(
      name: 'Shop',
      points: [
        ChartPoint(name: 'Mon', value: 12),
        ChartPoint(name: 'Tue', value: 23),
        ChartPoint(name: 'Fri', value: 23),
      ],
      color: context.colors.success,
    ),
    ChartSeriesData(
      name: 'Parking',
      points: [
        ChartPoint(name: 'Mon', value: 54),
        ChartPoint(name: 'Tue', value: 23),
        ChartPoint(name: 'Fri', value: 23),
      ],
      color: context.colors.warning,
    ),
  ];
  return AppBarChartStatCard(
    title: 'Title',
    chartSeriesData: data,
    actions: [
      CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        minimumSize: Size(0, 0),
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            BetterIcons.filterHorizontalOutline,
            size: 20,
            color: context.colors.onSurface,
          ),
        ),
      ),
      CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        minimumSize: Size(0, 0),
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            BetterIcons.moreVerticalCircle01Outline,
            size: 20,
            color: context.colors.onSurface,
          ),
        ),
      ),
    ],
    leading: AppToggleSwitchButtonGroup(
      options: [
        ToggleSwitchButtonGroupOption(value: 1, label: 'Label'),
        ToggleSwitchButtonGroupOption(value: 2, label: 'Label'),
        ToggleSwitchButtonGroupOption(value: 3, label: 'Label'),
      ],
      selectedValue: 1,
      onChanged: (value) {},
    ),
    percent: 41,
    subtitle: 'subtitle',
    totalNumber: '1,000,000',
  );
}
