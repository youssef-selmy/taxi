import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/blocs/customer_accounting_detail.bloc.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/components/header.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/components/transactions_table.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/components/wallet_summary.dart';

@RoutePage()
class CustomerAccountingDetailScreen extends StatelessWidget {
  final String? customerId;

  const CustomerAccountingDetailScreen({
    super.key,
    @PathParam('customerId') this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerAccountingDetailBloc()
        ..onStarted(
          currency: context.read<AuthBloc>().state.selectedCurrency,
          customerId: customerId!,
        ),
      child: Column(
        children: [
          const CustomerAccoutingDetailHeader(),
          Transform.translate(
            offset: const Offset(0, -42),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CustomerAccountingDetailWalletSummary(),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CustomerAccountingDetailTransactionsTable(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
