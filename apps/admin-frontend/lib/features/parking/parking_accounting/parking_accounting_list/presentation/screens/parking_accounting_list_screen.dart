import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/presentation/blocs/parking_accounting_list.cubit.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/presentation/components/header.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/presentation/components/summary.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/presentation/components/wallets_table.dart';

@RoutePage()
class ParkingAccountingListScreen extends StatelessWidget {
  const ParkingAccountingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingAccountingListBloc()
        ..onStarted(currency: context.read<AuthBloc>().state.selectedCurrency),
      child: Container(
        margin: context.pagePadding,
        decoration: BoxDecoration(color: context.colors.surface),
        child: const Column(
          children: [
            ParkingAccountingListHeader(),
            SizedBox(height: 24),
            ParkingAccountingListSummary(),
            SizedBox(height: 24),
            Expanded(child: ParkingAccountingListWalletsTable()),
          ],
        ),
      ),
    );
  }
}
