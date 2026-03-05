import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/presentation/blocs/shop_accounting_detail.cubit.dart';

class ShopAccountingDetailWalletSummary extends StatelessWidget {
  const ShopAccountingDetailWalletSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopAccountingDetailBloc, ShopAccountingDetailState>(
      builder: (context, state) {
        return WalletBalanceCard(
          items: state.walletSummaryState.mapData(
            (data) => data.shop.wallet
                .map((wallet) => wallet.toWalletBalanceItem())
                .toList(),
          ),
        );
      },
    );
  }
}
