import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/charts/line_chart_gradient.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/presentation/blocs/driver_detail_credit_records.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailCreditRecordsStatistics extends StatefulWidget {
  const DriverDetailCreditRecordsStatistics({super.key});

  @override
  State<DriverDetailCreditRecordsStatistics> createState() =>
      _DriverDetailCreditRecordsStatisticsState();
}

class _DriverDetailCreditRecordsStatisticsState
    extends State<DriverDetailCreditRecordsStatistics> {
  @override
  void initState() {
    context
        .read<DriverDetailCreditRecordsBloc>()
        .fetchEarningsOverTimeStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverDetailCreditRecordsBloc,
      DriverDetailCreditRecordsState
    >(
      builder: (context, state) {
        var data = state.earningsOverTimeStatisticsState.data;
        return Column(
          children: [
            SizedBox(
              height: 299,
              child: ChartCard(
                filters: [
                  ChartFilterInputs(
                    onChanged: (filterInput) {
                      context
                          .read<DriverDetailCreditRecordsBloc>()
                          .onEarningsOverTimeFilterChanged(filterInput);
                    },
                  ),
                ],
                title: context.tr.earningsOverTime,
                subtitle: context.tr.driverEarningsOverTimeDescription,
                child: Skeletonizer(
                  enableSwitchAnimation: true,
                  enabled: state.earningsOverTimeStatisticsState.isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LineChartGradient<Enum$UserActivityLevel>(
                      data: state.earningsOverTimeStatisticsState.isLoading
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
            ),
            SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
