import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/presentation/blocs/driver_accounting_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/presentation/components/header.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/presentation/components/transactions_table.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/presentation/components/wallet_summary.dart';

@RoutePage()
class DriverAccountingDetailScreen extends StatelessWidget {
  final String? driverId;

  const DriverAccountingDetailScreen({
    super.key,
    @PathParam('driverId') this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverAccountingDetailBloc()
        ..onStarted(
          currency: context.read<AuthBloc>().state.selectedCurrency,
          driverId: driverId!,
        ),
      child: Column(
        children: [
          const DriverAccoutingDetailHeader(),
          Transform.translate(
            offset: const Offset(0, -42),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: DriverAccountingDetailWalletSummary(),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: DriverAccountingDetailTransactionsTable(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
