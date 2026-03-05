import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/blocs/taxi_order_detail_transactions.cubit.dart';

class TaxiOrderCustomerTransactions extends StatelessWidget {
  const TaxiOrderCustomerTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      TaxiOrderDetailTransactionsBloc,
      TaxiOrderDetailTransactionsState
    >(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.customerTransactions.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.customer,
                      style: context.textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      context.tr.total,
                      style: context.textTheme.labelMedium,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.sumCustomerTransactions.formatCurrency(
                        state.taxiOrderTransactionsState.data?.order.currency ??
                            Env.defaultCurrency,
                      ),
                      style: context.textTheme.headlineSmall?.apply(
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 48),
                  shrinkWrap: true,
                  itemCount: state.customerTransactions.isLoading
                      ? 2
                      : state.customerTransactions.data!.length,
                  itemBuilder: (context, index) {
                    final customerTransaction =
                        state.customerTransactions.isLoading
                        ? mockCustomerTransaction1
                        : state.customerTransactions.data!.elementAt(index);
                    return Row(
                      children: <Widget>[
                        Text(
                          customerTransaction.createdAt.formatDateTime,
                          style: context.textTheme.labelMedium,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          flex: 2,
                          child: customerTransaction.tableViewType(context),
                        ),
                        context.responsive(
                          const SizedBox(),
                          lg: Expanded(
                            flex: 2,
                            child: customerTransaction.tableViewPaymentMethod(
                              context,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customerTransaction.status.chip(context),
                            ],
                          ),
                        ),
                        customerTransaction.amount.toCurrency(
                          context,
                          customerTransaction.currency,
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
