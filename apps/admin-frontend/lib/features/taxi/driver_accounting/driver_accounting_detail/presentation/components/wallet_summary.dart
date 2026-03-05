import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/presentation/blocs/driver_accounting_detail.cubit.dart';

class DriverAccountingDetailWalletSummary extends StatelessWidget {
  const DriverAccountingDetailWalletSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverAccountingDetailBloc, DriverAccountingDetailState>(
      builder: (context, state) {
        return WalletBalanceCard(
          items: state.walletSummaryState.mapData(
            (data) => data.driver.wallet
                .map((wallet) => wallet.toWalletBalanceItem())
                .toList(),
          ),
        );
      },
    );
  }
}
