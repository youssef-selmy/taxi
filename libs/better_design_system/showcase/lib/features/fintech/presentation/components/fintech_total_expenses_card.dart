import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

enum FintechTotalExpensesStyle { styleA, styleB }

class FintechTotalExpensesCard extends StatelessWidget {
  final FintechTotalExpensesStyle style;
  const FintechTotalExpensesCard({
    super.key,
    this.style = FintechTotalExpensesStyle.styleA,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChartSeriesData> data = [
      ChartSeriesData(
        name: 'Total Expenses',
        points: [
          ChartPoint(name: 'Jun', value: 3200),
          ChartPoint(name: 'May', value: 3100),
          ChartPoint(name: 'Apr', value: 3150),
          ChartPoint(name: 'Jan', value: 3000),
          ChartPoint(name: 'Feb', value: 3100),
          ChartPoint(name: 'Mar', value: 3050),
        ],
        color: context.colors.error,
        isCurved: true,
      ),
    ];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(
          style == FintechTotalExpensesStyle.styleB ? 12 : 16,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Expenses',
            style: context.textTheme.labelLarge?.variant(context),
          ),
          SizedBox(height: style == FintechTotalExpensesStyle.styleA ? 8 : 20),

          if (style == FintechTotalExpensesStyle.styleA) ...[
            _getPrice(context),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: SizedBox(height: 90, child: _getChart(data))),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppIconButton(
                        icon: BetterIcons.arrowDown02Outline,
                        onPressed: () {},
                        style: IconButtonStyle.outline,
                        size: ButtonSize.medium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          if (style == FintechTotalExpensesStyle.styleB) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _getPrice(context),
                SizedBox(height: 56, width: 110, child: _getChart(data)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _getPrice(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      direction:
          style == FintechTotalExpensesStyle.styleA
              ? Axis.horizontal
              : Axis.vertical,
      children: <Widget>[
        Text('\$5,960.80', style: context.textTheme.headlineSmall),
        AppBadge(
          prefixIcon: BetterIcons.arrowDown01Outline,
          text: '-3.3%',
          size: BadgeSize.small,
          color: SemanticColor.error,
        ),
      ],
    );
  }

  Widget _getChart(List<ChartSeriesData> data) {
    return AppLinearSparkline(data: data, hasLine: true, hasArea: true);
  }
}
