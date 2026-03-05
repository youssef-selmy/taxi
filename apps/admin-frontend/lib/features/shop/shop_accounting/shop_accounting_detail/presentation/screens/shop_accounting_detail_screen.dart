import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/presentation/blocs/shop_accounting_detail.cubit.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/presentation/components/header.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/presentation/components/transactions_table.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/presentation/components/wallet_summary.dart';

@RoutePage()
class ShopAccountingDetailScreen extends StatelessWidget {
  final String? shopId;

  const ShopAccountingDetailScreen({
    super.key,
    @PathParam('shopId') this.shopId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAccountingDetailBloc()
        ..onStarted(
          currency: context.read<AuthBloc>().state.selectedCurrency,
          shopId: shopId!,
        ),
      child: Column(
        children: [
          const ShopAccoutingDetailHeader(),
          Transform.translate(
            offset: const Offset(0, -42),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ShopAccountingDetailWalletSummary(),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ShopAccountingDetailTransactionsTable(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
