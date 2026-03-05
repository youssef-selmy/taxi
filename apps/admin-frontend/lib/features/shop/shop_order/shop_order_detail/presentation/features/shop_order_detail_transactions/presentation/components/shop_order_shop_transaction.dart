import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/blocs/shop_order_detail_transactions.cubit.dart';

class ShopOrderShopTransaction extends StatelessWidget {
  const ShopOrderShopTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ShopOrderDetailTransactionsBloc,
      ShopOrderDetailTransactionsState
    >(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.shopTransactions.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.shop,
                      style: context.textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.providerTransactions.data?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final cart = state
                        .shopOrderTransactions
                        .data!
                        .shopOrder
                        .shopTransactions[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                if (cart.shop.image != null) ...[
                                  cart.shop.image!.widget(
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  cart.shop.name,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  context.tr.total,
                                  style: context.textTheme.labelMedium,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  (state.sumShopTransactions[index])
                                      .formatCurrency(
                                        state
                                                .shopOrderTransactions
                                                .data
                                                ?.shopOrder
                                                .currency ??
                                            Env.defaultCurrency,
                                      ),
                                  style: context.textTheme.headlineSmall?.apply(
                                    color: context.colors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const Divider(height: 48),
                          shrinkWrap: true,
                          itemCount: state.shopTransactions.isLoading
                              ? 2
                              : cart.shopTransactions.length,
                          itemBuilder: (context, transactionIndex) {
                            final shopTransaction =
                                state.shopTransactions.isLoading
                                ? mockShopTransaction1
                                : cart.shopTransactions[transactionIndex];
                            return Row(
                              children: <Widget>[
                                Text(
                                  shopTransaction.createdAt.formatDateTime,
                                  style: context.textTheme.labelMedium,
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  flex: 2,
                                  child: shopTransaction.tableViewType(context),
                                ),
                                context.responsive(
                                  const SizedBox(),
                                  lg: Expanded(
                                    flex: 2,
                                    child: shopTransaction
                                        .tableViewPaymentMethod(context),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      shopTransaction.status.chip(context),
                                    ],
                                  ),
                                ),
                                shopTransaction.amount.toCurrency(
                                  context,
                                  shopTransaction.currency,
                                  colored: true,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
