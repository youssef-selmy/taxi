import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/blocs/customer_accounting_detail.bloc.dart';

class CustomerAccountingDetailWalletSummary extends StatelessWidget {
  const CustomerAccountingDetailWalletSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      CustomerAccountingDetailBloc,
      CustomerAccountingDetailState
    >(
      builder: (context, state) {
        return WalletBalanceCard(
          items: state.walletSummaryState.mapData(
            (data) => data.rider.wallet
                .map((wallet) => wallet.toWalletBalanceItem())
                .toList(),
          ),
        );
      },
    );
  }
}
