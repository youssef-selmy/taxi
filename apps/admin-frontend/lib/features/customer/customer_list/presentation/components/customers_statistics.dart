import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_b.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/active_inactive_users.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/country_distribution.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/customers_per_app_pie_chart.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/gender_distribution_pie_chart.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/platform_distribution_pie_chart.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/retention_rate_bar_chart.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/revenue_per_app_bar_chart.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/charts/top_spending_customers_list.dart';

class CustomersStatistics extends StatelessWidget {
  const CustomersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CustomersStatisticsBloc>().onStarted();
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        final data = state.stats.data;
        if (data == null) {
          return const Center(child: CupertinoActivityIndicator());
        }
        final customersPerApp = data.customersPerApp;
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16),
          child: SafeArea(
            top: false,
            child: LayoutGrid(
              rowGap: 16,
              columnGap: 16,
              columnSizes: context.responsive(
                [1.fr],
                lg: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
              ),
              rowSizes: context.responsive(
                [
                  auto,
                  auto,
                  auto,
                  auto,
                  auto,
                  auto,
                  400.px,
                  400.px,
                  400.px,
                  400.px,
                  auto,
                  400.px,
                  400.px,
                  auto,
                  400.px,
                  400.px,
                ],
                lg: [
                  auto,
                  auto,
                  auto,
                  400.px,
                  400.px,
                  auto,
                  400.px,
                  auto,
                  400.px,
                  auto,
                ],
              ),
              children: [
                Text(
                  "Total customers",
                  style: context.textTheme.titleMedium,
                ).withGridPlacement(columnSpan: context.responsive(1, lg: 8)),
                KPICardStyleB(
                  title: "Total",
                  value: state.totalCustomersCount.toStringAsFixed(0),
                  icon: const dartz.Left(BetterIcons.userMultipleFilled),
                ).withGridPlacement(columnSpan: context.responsive(1, lg: 2)),
                ...customersPerApp.mapIndexed(
                  (index, element) => KPICardStyleB(
                    title: element.app.name,
                    value: element.count.toStringAsFixed(0),
                    icon:
                        context
                                .read<ConfigBloc>()
                                .state
                                .appConfig(element.app)
                                .logo !=
                            null
                        ? dartz.Right(
                            context
                                .read<ConfigBloc>()
                                .state
                                .appConfig(element.app)
                                .logo!,
                          )
                        : null,
                  ).withGridPlacement(columnSpan: context.responsive(1, lg: 2)),
                ),
                ...List.generate(
                  3 - customersPerApp.length,
                  (index) => const SizedBox().withGridPlacement(
                    columnSpan: context.responsive(1, lg: 2),
                  ),
                ),
                Text(
                  context.tr.customerSpendingBehaviors,
                  style: context.textTheme.titleMedium,
                ).withGridPlacement(columnSpan: context.responsive(1, lg: 8)),
                const CustomersPerAppPieChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 3),
                ),
                const RevenuePerAppBarChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 5),
                ),
                const TopSpendingCustomersList().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 4),
                ),
                const CustomerPlatformDistributionPieChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 4),
                ),
                Text(
                  context.tr.usageStatistics,
                  style: context.textTheme.titleMedium,
                ).withGridPlacement(columnSpan: context.responsive(1, lg: 8)),
                const RetentionRateBarChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 4),
                ),
                const ActiveInactiveUserChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 4),
                ),
                Text(
                  context.tr.customerInformation,
                  style: context.textTheme.titleMedium,
                ).withGridPlacement(columnSpan: context.responsive(1, lg: 8)),
                const CustomersGenderDistributionPieChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 2),
                ),
                const CountryDistributionBarChart().withGridPlacement(
                  columnSpan: context.responsive(1, lg: 6),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
