import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/components/charts/line_chart_one.dart';
import 'package:admin_frontend/core/enums/activity_level.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_localization/localizations.dart';

class ActiveInactiveUserChart extends StatelessWidget {
  const ActiveInactiveUserChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        return ChartCard(
          filters: [
            ChartFilterInputs(
              onChanged: (filterInput) {
                context
                    .read<CustomersStatisticsBloc>()
                    .onActiveInactiveUsersFilterChanged(filterInput);
              },
            ),
          ],
          title: context.tr.activeInactiveUsers,
          subtitle: context.tr.activeInactiveUsersPerMonth,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LineChartOne<Enum$UserActivityLevel>(
              data:
                  state.stats.data?.activeInactiveUsers.toChartSeriesData(
                    state.activeInactiveUsersFilter,
                    context,
                  ) ??
                  [],
              bottomTitleBuilder: (data) => data.name,
              leftTitleBuilder: (value) => value.toInt().toString(),
              groupLabelBuilder: (p0) {
                return p0.name(context);
              },
            ),
          ),
        );
      },
    );
  }
}
