import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/enums/device_platform_enum.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:better_localization/localizations.dart';

class CustomerPlatformDistributionPieChart extends StatelessWidget {
  const CustomerPlatformDistributionPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        final data = state.stats.data?.customerPlatformDistribution ?? [];
        return ChartCard(
          title: context.tr.customerPlatformDistribution,
          subtitle: context.tr.totalCustomersPerPlatform,
          footer: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: data.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChartIndicator(
                    color: e.platform.color,
                    title: "${e.platform.name(context)} (${e.count})",
                    icon: e.platform.icon,
                  ),
                );
              }).toList(),
            ),
          ),
          child: RingChart(data: data.toChartSeriesData(context)),
        );
      },
    );
  }
}
