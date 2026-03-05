import 'package:admin_frontend/config/env.dart';
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
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/blocs/driver_detail_orders.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailOrdersStatisticsRideAcceptance extends StatefulWidget {
  const DriverDetailOrdersStatisticsRideAcceptance({super.key});

  @override
  State<DriverDetailOrdersStatisticsRideAcceptance> createState() =>
      _DriverDetailOrdersStatisticsRideAcceptanceState();
}

class _DriverDetailOrdersStatisticsRideAcceptanceState
    extends State<DriverDetailOrdersStatisticsRideAcceptance> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailOrdersBloc>();
    return SizedBox(
      height: 368,
      child: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<DriverDetailOrdersBloc, DriverDetailOrdersState>(
          builder: (context, state) {
            final data = state.rideAcceptanceStatisticsState.isLoading
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
                : state.rideAcceptanceStatisticsState.data;
            if (data == null) {
              return const SizedBox();
            }

            return ChartCard(
              title: context.tr.rideAcceptanceRate,
              subtitle: context.tr.rideAcceptanceRateDescription,
              filters: [
                ChartFilterInputs(
                  onChanged: (filterInput) =>
                      bloc.onRideAcceptanceFilterChanged(filterInput),
                ),
              ],
              footer: Skeletonizer(
                enabled: state.rideAcceptanceStatisticsState.isLoading,
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
                                "${appConfig.name} (${totalRevenue.formatCurrency(Env.defaultCurrency)})",
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
                    state.rideAcceptanceFilter,
                    context,
                  ),
                  bottomTitleBuilder: (data) => data.name,
                  leftTitleBuilder: (value) =>
                      value.formatCurrency(Env.defaultCurrency),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
