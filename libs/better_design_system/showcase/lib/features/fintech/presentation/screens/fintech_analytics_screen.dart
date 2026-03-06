import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image_faker/image_faker.dart';

@RoutePage()
class FintechAnalyticsScreen extends StatefulWidget {
  const FintechAnalyticsScreen({super.key});

  @override
  State<FintechAnalyticsScreen> createState() => _FintechAnalyticsScreenState();
}

class _FintechAnalyticsScreenState extends State<FintechAnalyticsScreen> {
  final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final values = [800.0, 1200.0, 600.0, 1000.0, 900.0, 700.0, 1100.0];

  final List<String> chartTabs = ['Income', 'Outcome'];

  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = chartTabs.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Analytics', style: context.textTheme.titleSmall),
                ],
              ),
            ),
            SizedBox(height: 16),
            AppToggleSwitchButtonGroup<String>(
              isExpanded: true,
              options:
                  chartTabs
                      .map(
                        (e) =>
                            ToggleSwitchButtonGroupOption(value: e, label: e),
                      )
                      .toList(),
              selectedValue: selectedTab,
              onChanged: (value) {
                setState(() {
                  selectedTab = value;
                });
              },
            ),
            SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Overview', style: context.textTheme.titleSmall),
                    Text(
                      'Oct 10,2024 - Oct 17 2024',
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),

                SizedBox(
                  width: 93,
                  child: AppDropdownField.single(
                    items: [
                      AppDropdownItem(value: 'Daily', title: 'Daily'),
                      AppDropdownItem(value: 'Weekly', title: 'Weekly'),
                      AppDropdownItem(value: 'Monthly', title: 'Monthly'),
                      AppDropdownItem(value: 'Yearly', title: 'Yearly'),
                    ],
                    type: DropdownFieldType.compact,
                    isFilled: false,
                    initialValue: 'Weekly',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 240,
              child: BarChart(
                BarChartData(
                  maxY: 2000,
                  minY: 0,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 500,
                    getDrawingHorizontalLine:
                        (value) => FlLine(
                          color: context.colors.outlineVariant,
                          dashArray: [4, 4],
                          strokeWidth: 1,
                        ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                        interval: 500,
                        getTitlesWidget: (value, meta) {
                          final label = '\$${value.toInt()}';
                          return Text(
                            label,
                            style: context.textTheme.bodySmall?.variant(
                              context,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return Text(
                            index >= 0 && index < weekdays.length
                                ? weekdays[index]
                                : '',
                            style: context.textTheme.bodySmall?.variant(
                              context,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(weekdays.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: values[i],
                          width: 16,
                          borderRadius: BorderRadius.circular(100),
                          color: context.colors.primary,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text('Details', style: context.textTheme.titleSmall),
            SizedBox(height: 16),

            Column(
              children: [
                _getDetailItem(
                  context,
                  avatar: ImageFaker().person.one,
                  title: 'Kara White',
                  subtitle: '18:59',
                  price: '\$100',
                  leadingSubtitle: 'Transfer',
                ),
                AppDivider(height: 36),
                _getDetailItem(
                  context,
                  avatar: ImageFaker().person.two,
                  title: 'Richard Hill',
                  subtitle: '22:21',
                  price: '\$200',
                  leadingSubtitle: 'Withdraw',
                ),
                AppDivider(height: 36),
                _getDetailItem(
                  context,
                  avatar: ImageFaker().person.three,
                  title: 'Frederick Dimatteo',
                  subtitle: '08:51',
                  price: '\$78',
                  leadingSubtitle: 'Transfer',
                ),
                AppDivider(height: 36),
                _getDetailItem(
                  context,
                  avatar: ImageFaker().person.four,
                  title: 'Aletha Parish',
                  subtitle: '09:23',
                  price: '\$250',
                  leadingSubtitle: 'Transfer',
                ),
                AppDivider(height: 36),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _getDetailItem(
    BuildContext context, {
    required String avatar,
    required String title,
    required String subtitle,
    required String price,
    required String leadingSubtitle,
  }) => Row(
    children: [
      AppAvatar(imageUrl: avatar, size: AvatarSize.size40px),
      SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(title, style: context.textTheme.labelLarge),
          Text(subtitle, style: context.textTheme.bodySmall?.variant(context)),
        ],
      ),
      Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 4,
        children: [
          Text(price, style: context.textTheme.labelLarge),
          Text(
            leadingSubtitle,
            style: context.textTheme.bodySmall?.variant(context),
          ),
        ],
      ),
    ],
  );
}
