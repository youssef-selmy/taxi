import 'package:api_response/api_response.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/balance_analysis_chart_card.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/expense_breakdown_chart_card.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/header.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/profit_and_revenue_chart_card.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/transaction_breakdown_cards.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/admin_accounting_transactions_list.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/components/wallet_balance_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class AdminAccountingDashboardScreen extends StatelessWidget {
  const AdminAccountingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminAccountingDashboardBloc()..onStarted(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.selectedCurrency != current.selectedCurrency,
            listener: (context, state) => context
                .read<AdminAccountingDashboardBloc>()
                .changeCurrency(state.selectedCurrency),
          ),
          BlocListener<
            AdminAccountingDashboardBloc,
            AdminAccountingDashboardState
          >(
            listenWhen: (previous, current) =>
                previous.exportState != current.exportState,
            listener: (context, state) {
              switch (state.exportState) {
                case ApiResponseLoaded(:final data):
                  context.showSuccess(context.tr.successExportMessage);
                  launchUrlString(data);
                  break;

                case ApiResponseError():
                  context.showFailure(state.exportState);
                  break;

                default:
                  break;
              }
            },
          ),
        ],
        child: Container(
          color: context.colors.surface,
          child: SingleChildScrollView(
            padding: context.pagePadding,
            child: Column(
              children: [
                const AdminAccountingDashboardHeader(),
                const SizedBox(height: 16),
                LayoutGrid(
                  columnSizes: List.generate(
                    context.isDesktop ? 2 : 1,
                    (_) => 1.fr,
                  ),
                  columnGap: 16,
                  rowGap: 16,
                  rowSizes: List.generate(
                    context.isDesktop ? 4 : 6,
                    (_) => auto,
                  ),
                  children: [
                    const AdminAccountingDashboardWalletBalanceCard(),
                    const AdminAccountingDashboardTransactionsBreakdownCards(),
                    const AdminAccountingDashboardBalanceAnalysisChartCard(),
                    const AdminAccountingDashboardExpenseBreakdownChartCard(),
                    const AdminAccountingDashboardProfitAndRevenueChartCard()
                        .withGridPlacement(
                          columnSpan: context.responsive(1, lg: 2),
                        ),
                    const AdminAccountingDashboardTransactionList()
                        .withGridPlacement(
                          columnSpan: context.responsive(1, lg: 2),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
