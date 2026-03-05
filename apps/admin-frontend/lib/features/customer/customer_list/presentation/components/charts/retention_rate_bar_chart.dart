import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:better_localization/localizations.dart';

class RetentionRateBarChart extends StatelessWidget {
  const RetentionRateBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        return ChartCard(
          title: context.tr.retentionRate,
          subtitle: context.tr.retentionRatePerMonth,
          filters: [
            ChartFilterInputs(
              onChanged: (filterInput) {
                context
                    .read<CustomersStatisticsBloc>()
                    .onRetentionFilterChanged(filterInput);
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BarChartThin(
              data:
                  state.stats.data?.retentionRate.toChartSeriesData(
                    state.retentionFilter,
                    context,
                  ) ??
                  [],
              bottomTitleBuilder: (data) => data.name,
              leftTitleBuilder: (value) => "${(value).toStringAsFixed(0)}%",
              leftReservedSize: 30,
            ),
          ),
        );
      },
    );
  }
}
