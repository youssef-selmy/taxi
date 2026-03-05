import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/presentation/blocs/driver_accounting_list.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/presentation/components/header.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/presentation/components/summary.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/presentation/components/wallets_table.dart';

@RoutePage()
class DriverAccountingListScreen extends StatelessWidget {
  const DriverAccountingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverAccountingListBloc()
            ..onStarted(currency: locator<AuthBloc>().state.selectedCurrency),
      child: Container(
        margin: context.pagePadding,
        decoration: BoxDecoration(color: context.colors.surface),
        child: const Column(
          children: [
            DriverAccountingListHeader(),
            SizedBox(height: 24),
            DriverAccountingListSummary(),
            SizedBox(height: 24),
            Expanded(child: DriverAccountingListWalletsTable()),
          ],
        ),
      ),
    );
  }
}
