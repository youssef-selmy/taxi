import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/blocs/customer_accounting_list.bloc.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/components/header.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/components/summary.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/components/wallets_table.dart';

@RoutePage()
class CustomerAccountingListScreen extends StatelessWidget {
  const CustomerAccountingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerAccountingListBloc()
        ..onStarted(currency: context.read<AuthBloc>().state.selectedCurrency),
      child: Container(
        margin: context.pagePadding,
        decoration: BoxDecoration(color: context.colors.surface),
        child: const Column(
          children: [
            CustomerAccountingListHeader(),
            SizedBox(height: 24),
            CustomerAccountingListSummary(),
            SizedBox(height: 24),
            Expanded(child: CustomerAccountingListWalletsTable()),
          ],
        ),
      ),
    );
  }
}
