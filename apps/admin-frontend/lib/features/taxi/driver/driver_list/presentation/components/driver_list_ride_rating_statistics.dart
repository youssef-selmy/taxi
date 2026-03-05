import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';

class DriverListRideCompletionChat extends StatelessWidget {
  const DriverListRideCompletionChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverListBloc, DriverListState>(
      builder: (context, state) {
        final List<Query$rideCountByStatus$orderAggregate> data =
            state.rideCompletionStatisticsState.isLoading
            ? []
            : state.rideCompletionStatisticsState.data!.orderAggregate;
        return SizedBox(
          height: 368,
          child: ChartCard(
            title: context.tr.rideCompletionRate,
            subtitle: context.tr.rideCompletionRateDescription,
            footer: Skeletonizer(
              enabled: state.rideCompletionStatisticsState.isLoading,
              enableSwitchAnimation: true,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: data.mapIndexed((index, e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChartIndicator(
                        color: pieChartColors[index],
                        title:
                            "${e.groupBy?.status?.name(context)} (${e.count?.id ?? 0})",
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            child: RingChart(
              data: data
                  .mapIndexed(
                    (index, e) => ChartSeriesData(
                      name: e.groupBy?.status?.name(context) ?? "-",
                      color: pieChartColors[index],
                      value: e.count?.id?.toDouble() ?? 0,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
