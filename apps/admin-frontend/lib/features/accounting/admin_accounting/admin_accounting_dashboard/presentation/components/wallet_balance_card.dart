import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_summary.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';
import 'package:better_icons/better_icons.dart';

class AdminAccountingDashboardWalletBalanceCard extends StatelessWidget {
  const AdminAccountingDashboardWalletBalanceCard({super.key});

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
            return WalletBalanceCard(
              header: WalletBalanceSummary(
                currency: stateAuth.selectedCurrency,
                icon: BetterIcons.wallet01Filled,
                amount:
                    (state.adminWallets.data ?? [])
                        .firstWhereOrNull(
                          (walletBalance) =>
                              walletBalance.currency ==
                              stateAuth.selectedCurrency,
                        )
                        ?.balance ??
                    0,
                color: WalletBalanceSummaryColor.primary,
                title: context.tr.totalBalance,
              ),
              items: state.adminWallets,
            );
          },
        );
      },
    );
  }
}
