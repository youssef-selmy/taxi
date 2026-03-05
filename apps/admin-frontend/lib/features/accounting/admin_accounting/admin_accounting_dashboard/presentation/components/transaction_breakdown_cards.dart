import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_summary.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';
import 'package:better_icons/better_icons.dart';

class AdminAccountingDashboardTransactionsBreakdownCards
    extends StatelessWidget {
  const AdminAccountingDashboardTransactionsBreakdownCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.selectedCurrency != current.selectedCurrency,
      builder: (context, stateAuth) {
        return BlocBuilder<
          AdminAccountingDashboardBloc,
          AdminAccountingDashboardState
        >(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.summaryState.isLoading,
              enableSwitchAnimation: true,
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: WalletBalanceSummary(
                        icon: BetterIcons.arrowUpRight01Outline,
                        currency: stateAuth.selectedCurrency,
                        amount: state.totalRevenue.data?.total ?? 0,
                        color: WalletBalanceSummaryColor.green,
                        title: context.tr.revenue,
                        delta: (
                          ((state.totalRevenue.data?.total ?? 0) -
                              (state.totalRevenue.data?.daily ?? 0)),
                          state.totalRevenue.data?.total ?? 0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: WalletBalanceSummary(
                        icon: BetterIcons.arrowDownLeft01Outline,
                        currency: stateAuth.selectedCurrency,
                        amount: 89,
                        color: WalletBalanceSummaryColor.red,
                        title: context.tr.expense,
                        delta: (90, 100),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: WalletBalanceSummary(
                        icon: BetterIcons.money03Filled,
                        currency: stateAuth.selectedCurrency,
                        amount: 31,
                        color: WalletBalanceSummaryColor.orange,
                        title: context.tr.userWalletBalances,
                        delta: (30, 30),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
