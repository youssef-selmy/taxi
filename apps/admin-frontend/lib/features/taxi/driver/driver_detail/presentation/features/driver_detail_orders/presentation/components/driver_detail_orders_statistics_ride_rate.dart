import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/enums/gender.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/blocs/driver_detail_orders.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailOrdersStatisticsRideRate extends StatelessWidget {
  const DriverDetailOrdersStatisticsRideRate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDetailOrdersBloc, DriverDetailOrdersState>(
      builder: (context, state) {
        final data = state.rideCompletionStatisticsState.isLoading
            ? [
                Fragment$GenderDistribution(
                  gender: Enum$Gender.Female,
                  count: 7314,
                ),
                Fragment$GenderDistribution(
                  gender: Enum$Gender.Male,
                  count: 10242,
                ),
              ]
            : state.rideCompletionStatisticsState.data;
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
                  children: data!.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChartIndicator(
                        color: e.gender.color,
                        title: "${e.gender.name(context)} (${e.count.toInt()})",
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            child: RingChart(data: data.toChartSeriesData(context)),
          ),
        );
      },
    );
  }
}
