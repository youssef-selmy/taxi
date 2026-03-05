import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/pie_chart_one.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:better_localization/localizations.dart';

class CustomersPerAppPieChart extends StatelessWidget {
  const CustomersPerAppPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        return ChartCard(
          title: context.tr.customersPerApp,
          subtitle: context.tr.totalCustomersPerApp,
          footer: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  state.stats.data?.customersPerApp
                      .mapIndexed(
                        (index, element) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ChartIndicator(
                            color: pieChartColors[index],
                            title:
                                "${context.read<ConfigBloc>().state.appConfig(element.app).name} (${element.count})",
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
          child: PieChartOne(
            data:
                state.stats.data?.customersPerApp.toChartSeriesData(context) ??
                [],
          ),
          // child: PieChart(
          //   PieChartData(
          //     sectionsSpace: 0,
          //     startDegreeOffset: 30,
          //     sections: state.stats.data?.customersPerApp
          //         .mapIndexed(
          //           (index, element) => PieChartSectionData(
          //             color: pieChartColors[index],
          //             value: element.count.toDouble(),
          //             showTitle: false,
          //             radius: 50 - index * 5,
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
        );
      },
    );
  }
}
