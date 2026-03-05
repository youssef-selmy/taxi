import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/charts/line_chart_one.dart';
import 'package:admin_frontend/core/enums/activity_level.dart';
import 'package:admin_frontend/schema.graphql.dart';

class FinancialStatistics extends StatelessWidget {
  const FinancialStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to the backend
    return ChartCard(
      filters: [ChartFilterInputs(onChanged: (filterInput) {})],
      title: context.tr.transactions,
      subtitle: context.tr.activeInactiveUsersPerMonth,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChartOne<Enum$UserActivityLevel>(
          data: [
            ChartSeriesData(name: 'Jan', value: 80),
            ChartSeriesData(name: 'Feb', value: 150),
            ChartSeriesData(name: 'Mar', value: 230),
          ],
          bottomTitleBuilder: (data) => data.name,
          leftTitleBuilder: (value) => value.toInt().toString(),
          groupLabelBuilder: (p0) {
            return p0.name(context);
          },
        ),
      ),
    );
  }
}
