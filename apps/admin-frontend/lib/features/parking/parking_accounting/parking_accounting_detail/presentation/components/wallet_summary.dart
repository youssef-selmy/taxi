import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/presentation/blocs/parking_accounting_detail.cubit.dart';

class ParkingAccountingDetailWalletSummary extends StatelessWidget {
  const ParkingAccountingDetailWalletSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ParkingAccountingDetailBloc,
      ParkingAccountingDetailState
    >(
      builder: (context, state) {
        return WalletBalanceCard(
          items: state.walletSummaryState.mapData(
            (data) => data.rider.parkingWallets
                .map((wallet) => wallet.toWalletBalanceItem())
                .toList(),
          ),
        );
      },
    );
  }
}
