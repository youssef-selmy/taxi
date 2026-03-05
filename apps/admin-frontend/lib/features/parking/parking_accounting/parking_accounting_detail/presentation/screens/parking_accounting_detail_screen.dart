import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/presentation/blocs/parking_accounting_detail.cubit.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/presentation/components/header.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/presentation/components/transactions_table.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/presentation/components/wallet_summary.dart';

@RoutePage()
class ParkingAccountingDetailScreen extends StatelessWidget {
  final String? parkingId;

  const ParkingAccountingDetailScreen({
    super.key,
    @PathParam('parkingId') this.parkingId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingAccountingDetailBloc()
        ..onStarted(
          currency: context.read<AuthBloc>().state.selectedCurrency,
          parkingId: parkingId!,
        ),
      child: Column(
        children: [
          const ParkingAccoutingDetailHeader(),
          Transform.translate(
            offset: const Offset(0, -42),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ParkingAccountingDetailWalletSummary(),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ParkingAccountingDetailTransactionsTable(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
