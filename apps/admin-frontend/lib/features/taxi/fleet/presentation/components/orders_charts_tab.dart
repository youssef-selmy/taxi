import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin_horizontal.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';

class FleetOrdersChartsTab extends StatefulWidget {
  const FleetOrdersChartsTab({super.key});

  @override
  State<FleetOrdersChartsTab> createState() => _FleetOrdersChartsTabState();
}

class _FleetOrdersChartsTabState extends State<FleetOrdersChartsTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChartCard(
            title: context.tr.customerOrderRegistrationBehaviors,
            subtitle: context.tr.retentionRatePerMonth,
            filters: [ChartFilterInputs(onChanged: (filterInput) {})],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BarChartThin(
                data: [
                  ChartSeriesData(name: 'Jan', value: 60),
                  ChartSeriesData(name: 'Feb', value: 38),
                  ChartSeriesData(name: 'Mar', value: 80),
                  ChartSeriesData(name: 'Apr', value: 55),
                  ChartSeriesData(name: 'May', value: 150),
                  ChartSeriesData(name: 'Jun', value: 30),
                ],
                bottomTitleBuilder: (data) => data.name,
                leftTitleBuilder: (value) => "${(value).toStringAsFixed(0)}%",
                leftReservedSize: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ChartCard(
            title: context.tr.customerOrderPaymentBehaviors,
            subtitle: context.tr.totalOrdersPaymentBehaviors,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BarChartThinHorizontal(
                data: [
                  ChartSeriesData(name: 'Mar', value: 80),
                  ChartSeriesData(name: 'Apr', value: 55),
                  ChartSeriesData(name: 'May', value: 150),
                  ChartSeriesData(name: 'Jun', value: 30),
                ],
                bottomTitleBuilder: (countryDistribution) =>
                    countryDistribution.name,
                leftTitleBuilder: (value) => value.toInt().toString(),
                leftReservedSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
