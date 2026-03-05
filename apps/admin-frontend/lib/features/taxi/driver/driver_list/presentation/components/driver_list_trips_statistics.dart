import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_stacked.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverListTripsStatistics extends StatelessWidget {
  const DriverListTripsStatistics({super.key});

  @override
  Widget build(BuildContext cdontext) {
    return SizedBox(
      height: 368,
      child: BlocProvider(
        create: (context) => DriverListBloc()..onStarted(),
        child: BlocBuilder<DriverListBloc, DriverListState>(
          builder: (context, state) {
            // TODO : After the api is added change it to the appropriate mock
            final data = state.tripsCompletedStatisticsState.isLoading
                ? <Fragment$RevenuePerApp>[
                    for (var app in Enum$AppType.values.where(
                      (app) => app != Enum$AppType.$unknown,
                    ))
                      for (var i = 1; i <= 12; i++)
                        Fragment$RevenuePerApp(
                          app: app,
                          date: DateTime(2024, i, 1),
                          revenue: (Random().nextInt(10) * 1000) + 20000,
                        ),
                  ]
                : state.tripsCompletedStatisticsState.data;
            if (data == null) {
              return const SizedBox();
            }

            return ChartCard(
              title: context.tr.tripsCompletedByHourDay,
              subtitle: context.tr.tripsCompletedByHourDayDescription,
              filters: [
                ChartFilterInputs(
                  onChanged: (filterInput) => context
                      .read<DriverListBloc>()
                      .onTripsCompletedFilterChanged(filterInput),
                ),
              ],
              footer: Skeletonizer(
                enabled: state.tripsCompletedStatisticsState.isLoading,
                enableSwitchAnimation: true,
                child: Row(
                  children: data
                      .groupListsBy((element) => element.app)
                      .values
                      .mapIndexed((index, element) {
                        final app = element.first.app;
                        final appConfig = context
                            .read<ConfigBloc>()
                            .state
                            .appConfig(app);
                        final totalRevenue = element
                            .map((e) => e.revenue)
                            .reduce((value, element) => value + element);
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ChartIndicator(
                            color: pieChartColors[index],
                            title:
                                "${appConfig.name} (${totalRevenue.formatCurrency(state.currency)})",
                          ),
                        );
                      })
                      .toList(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BarChartStacked(
                  data: data.toChartSeriesData(
                    state.tripsCompletedFilter,
                    context,
                  ),
                  bottomTitleBuilder: (data) => data.name,
                  leftTitleBuilder: (value) =>
                      value.formatCurrency(state.currency),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
