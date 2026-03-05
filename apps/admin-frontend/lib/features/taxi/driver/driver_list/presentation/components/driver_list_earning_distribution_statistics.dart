import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/charts/line_chart_gradient.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverListEarningDistributionStatistics extends StatelessWidget {
  const DriverListEarningDistributionStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverListBloc, DriverListState>(
      builder: (context, state) {
        var data = state.earningsDistributionStatisticsState.data;
        return SizedBox(
          height: 368,
          child: ChartCard(
            filters: [
              ChartFilterInputs(
                onChanged: (filterInput) {
                  context
                      .read<DriverListBloc>()
                      .onEarningsDistributionFilterChanged(filterInput);
                },
              ),
            ],
            title: context.tr.earningsDistribution,
            subtitle: context.tr.earningsDistributionDescription,
            child: Skeletonizer(
              enableSwitchAnimation: true,
              enabled: state.earningsDistributionStatisticsState.isLoading,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LineChartGradient<Enum$UserActivityLevel>(
                  data: state.earningsDistributionStatisticsState.isLoading
                      ? [
                          ChartSeriesData(name: 'Jan', value: 80),
                          ChartSeriesData(name: 'Feb', value: 150),
                          ChartSeriesData(name: 'Mar', value: 230),
                        ]
                      : data ?? [],
                  bottomTitleBuilder: (data) => data.name,
                  leftTitleBuilder: (value) => value.toInt().toString(),
                  groupLabelBuilder: (p0) {
                    return p0.name;
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
