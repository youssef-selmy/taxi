import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/charts/line_chart_gradient.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';

class AdminAccountingDashboardBalanceAnalysisChartCard extends StatelessWidget {
  const AdminAccountingDashboardBalanceAnalysisChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: context.tr.balanceAnalysis,
      subtitle: context.tr.balanceAnalysisWithinThePeriod,
      height: 350,
      child:
          BlocBuilder<
            AdminAccountingDashboardBloc,
            AdminAccountingDashboardState
          >(
            builder: (context, state) {
              return LineChartGradient(
                data:
                    state.providerWalletBalanceHistory.data?.toChartSeriesData(
                      context,
                    ) ??
                    [],
                bottomTitleBuilder: (data) => data.toString(),
                leftTitleBuilder: (data) => data.toString(),
                groupLabelBuilder: (data) => context.tr.balance,
              );
            },
          ),
    );
  }
}
