import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/blocs/shop_order_detail_transactions.cubit.dart';

class ShopOrderProviderTransaction extends StatelessWidget {
  const ShopOrderProviderTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ShopOrderDetailTransactionsBloc,
      ShopOrderDetailTransactionsState
    >(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.providerTransactions.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.provider,
                      style: context.textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.providerTransactions.data?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final cart = state.providerTransactions.data![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
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
                                  (state.sumProviderTransactions[index])
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
                          itemCount: state.providerTransactions.isLoading
                              ? 2
                              : cart.providerTransactions.length,
                          itemBuilder: (context, transactionIndex) {
                            final providerTransaction =
                                state.providerTransactions.isLoading
                                ? mockProviderTransaction1
                                : cart.providerTransactions[transactionIndex];
                            return Row(
                              children: <Widget>[
                                Text(
                                  providerTransaction.createdAt.formatDateTime,
                                  style: context.textTheme.labelMedium,
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  flex: 2,
                                  child: providerTransaction.tableViewType(
                                    context,
                                  ),
                                ),
                                context.responsive(
                                  const SizedBox(),
                                  lg: const Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                ),
                                const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [SizedBox()],
                                  ),
                                ),
                                providerTransaction.amount.toCurrency(
                                  context,
                                  providerTransaction.currency,
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
