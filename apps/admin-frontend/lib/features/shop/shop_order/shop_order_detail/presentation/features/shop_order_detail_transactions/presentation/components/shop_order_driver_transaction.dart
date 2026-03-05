import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/blocs/shop_order_detail_transactions.cubit.dart';

class DriverTransactionWidget extends StatelessWidget {
  const DriverTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ShopOrderDetailTransactionsBloc,
      ShopOrderDetailTransactionsState
    >(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.driverTransactions.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.tr.driver,
                      style: context.textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Text(
                          context.tr.total,
                          style: context.textTheme.labelMedium,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          (state.sumDriverTransactions).formatCurrency(
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
                  itemCount: state.driverTransactions.isLoading
                      ? 2
                      : state.driverTransactions.data!.length,
                  itemBuilder: (context, index) {
                    final driverTransaction = state.driverTransactions.isLoading
                        ? mockDriverTransaction1
                        : state.driverTransactions.data!.elementAt(index);
                    return Row(
                      children: <Widget>[
                        Text(
                          driverTransaction.createdAt.formatDateTime,
                          style: context.textTheme.labelMedium,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          flex: 2,
                          child: driverTransaction.tableViewType(context),
                        ),
                        context.responsive(
                          const SizedBox(),
                          lg: Expanded(
                            flex: 2,
                            child: driverTransaction.tableViewPaymentMethod(
                              context,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [driverTransaction.status.chip(context)],
                          ),
                        ),
                        driverTransaction.amount.toCurrency(
                          context,
                          driverTransaction.currency,
                          colored: true,
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
