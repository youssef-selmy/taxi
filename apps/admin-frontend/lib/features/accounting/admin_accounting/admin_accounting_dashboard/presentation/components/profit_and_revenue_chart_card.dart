import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_stacked.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';

class AdminAccountingDashboardProfitAndRevenueChartCard
    extends StatelessWidget {
  const AdminAccountingDashboardProfitAndRevenueChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: context.tr.revenueProfit,
      subtitle: context.tr.revenueAndProfitWithinThePeriod,
      height: 300,
      child:
          BlocBuilder<
            AdminAccountingDashboardBloc,
            AdminAccountingDashboardState
          >(
            builder: (context, state) {
              return BarChartStacked(
                data: [
                  ...state.summaryState.data?.providerRevenueExpenseHistory.map(
                        (record) => ChartSeriesData(
                          name: record.dateString,
                          value: record.revenue,
                          groupBy: context.tr.revenue,
                        ),
                      ) ??
                      [],
                  ...state.summaryState.data?.providerRevenueExpenseHistory.map(
                        (record) => ChartSeriesData(
                          name: record.dateString,
                          value: record.expense,
                          groupBy: context.tr.expense,
                        ),
                      ) ??
                      [],
                ],
                bottomTitleBuilder: (data) => data.name,
                leftTitleBuilder: (data) => data.formatCurrency(state.currency),
              );
            },
          ),
    );
  }
}
