import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin_colored.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AdminAccountingDashboardExpenseBreakdownChartCard
    extends StatelessWidget {
  const AdminAccountingDashboardExpenseBreakdownChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: context.tr.expenseBreakdown,
      subtitle: context.tr.breakdownOfExpenses,
      height: 350,
      child:
          BlocBuilder<
            AdminAccountingDashboardBloc,
            AdminAccountingDashboardState
          >(
            builder: (context, state) {
              return BarChartThinColored(
                data:
                    state.summaryState.data?.providerExpenseBreakdownHistory
                        .map(
                          (record) => ChartSeriesData<Enum$ProviderExpenseType>(
                            name: record.dateString,
                            value: record.value,
                            groupBy: record.expenseType,
                          ),
                        )
                        .toList() ??
                    [],
                bottomTitleBuilder: (data) => data.name,
                leftTitleBuilder: (data) => data.toString(),
              );
            },
          ),
    );
  }
}
