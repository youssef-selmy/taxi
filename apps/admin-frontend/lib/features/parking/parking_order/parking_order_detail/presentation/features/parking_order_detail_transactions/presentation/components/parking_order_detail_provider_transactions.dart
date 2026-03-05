import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/blocs/parking_order_detail_transactions.cubit.dart';

class ParkingOrderDetailProviderTransactions extends StatelessWidget {
  const ParkingOrderDetailProviderTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ParkingOrderDetailTransactionsBloc,
      ParkingOrderDetailTransactionsState
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.tr.provider,
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
                          (state.sumProviderTransactions).formatCurrency(
                            state
                                    .parkingOrderTransactionsState
                                    .data
                                    ?.parkOrder
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
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 48),
                  shrinkWrap: true,
                  itemCount: state.providerTransactions.isLoading
                      ? 2
                      : state.providerTransactions.data!.length,
                  itemBuilder: (context, index) {
                    final providerTransaction =
                        state.providerTransactions.isLoading
                        ? mockProviderTransactionList[0]
                        : state.providerTransactions.data!.elementAt(index);
                    return Row(
                      children: <Widget>[
                        Text(
                          providerTransaction.createdAt.formatDateTime,
                          style: context.textTheme.labelMedium,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          flex: 2,
                          child: providerTransaction.tableViewType(context),
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
            ),
          ),
        );
      },
    );
  }
}
