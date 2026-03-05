import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';

class DriverListActiveInactiveStatistics extends StatelessWidget {
  const DriverListActiveInactiveStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverListBloc, DriverListState>(
      builder: (context, state) {
        final data = state.activeInActiveStatisticsState.isLoading
            ? mockActiveInactiveUsers
            : state.activeInActiveStatisticsState.data;
        return SizedBox(
          height: 368,
          child: ChartCard(
            title: context.tr.activeInactiveDrivers,
            subtitle: context.tr.activeDriversLast30Days,
            footer: Skeletonizer(
              enabled: state.activeInActiveStatisticsState.isLoading,
              enableSwitchAnimation: true,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: data!.mapIndexed((index, e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChartIndicator(
                        color: activeInactiveColorsAlternative[index],
                        title: "${e.activityLevel.name} (${e.count.toInt()})",
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            child: RingChart(data: data.toChartSeriesDataNonTimed(context)),
          ),
        );
      },
    );
  }
}
