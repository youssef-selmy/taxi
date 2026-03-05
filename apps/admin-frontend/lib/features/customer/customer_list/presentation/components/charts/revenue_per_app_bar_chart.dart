import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_stacked.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:better_localization/localizations.dart';

class RevenuePerAppBarChart extends StatelessWidget {
  const RevenuePerAppBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomersStatisticsBloc>();
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        final data = state.stats.data?.revenuePerApp;
        if (data == null) {
          return const SizedBox();
        }
        final revenue = state.stats.data!.revenuePerApp;
        return ChartCard(
          title: context.tr.revenuePerApp,
          subtitle: context.tr.totalRevenuePerApp,
          filters: [
            ChartFilterInputs(
              onChanged: (filterInput) =>
                  bloc.onRevenueFilterChanged(filterInput),
            ),
          ],
          footer: Row(
            children: data
                .groupListsBy((element) => element.app)
                .values
                .mapIndexed((index, element) {
                  final app = element.first.app;
                  final appConfig = context.read<ConfigBloc>().state.appConfig(
                    app,
                  );
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BarChartStacked(
              data: revenue.toChartSeriesData(state.revenueFilter, context),
              bottomTitleBuilder: (data) => data.name,
              leftTitleBuilder: (value) =>
                  value.formatCurrency(Env.defaultCurrency),
            ),
          ),
        );
      },
    );
  }
}
