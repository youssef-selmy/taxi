import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin_horizontal.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:better_localization/localizations.dart';

class CountryDistributionBarChart extends StatelessWidget {
  const CountryDistributionBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        final countryDistribution = state.stats.data?.countryDistribution ?? [];
        return ChartCard(
          title: context.tr.distributionByCountry,
          subtitle: context.tr.totalCustomersRegistrationPerCountry,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BarChartThinHorizontal(
              data: countryDistribution.toChartSeriesData(),
              bottomTitleBuilder: (countryDistribution) =>
                  countryDistribution.name,
              leftTitleBuilder: (value) => value.toInt().toString(),
              leftReservedSize: 30,
            ),
          ),
        );
      },
    );
  }
}
