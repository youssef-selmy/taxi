import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/blocs/parking_order_detail_transactions.cubit.dart';

class ParkingOrderDetailParkOwnerTransactions extends StatelessWidget {
  const ParkingOrderDetailParkOwnerTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ParkingOrderDetailTransactionsBloc,
      ParkingOrderDetailTransactionsState
    >(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.parkOwnerTransactions.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.tr.parkOwner,
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
                          (state.sumParkOwnerTransactions).formatCurrency(
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
                  itemCount: state.parkOwnerTransactions.isLoading
                      ? 2
                      : state.parkOwnerTransactions.data!.length,
                  itemBuilder: (context, index) {
                    final parkOwnerTransaction =
                        state.parkOwnerTransactions.isLoading
                        ? mockCustomerTransaction1
                        : state.parkOwnerTransactions.data!.elementAt(index);
                    return Row(
                      children: <Widget>[
                        Text(
                          parkOwnerTransaction.createdAt.formatDateTime,
                          style: context.textTheme.labelMedium,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          flex: 2,
                          child: parkOwnerTransaction.tableViewType(context),
                        ),
                        context.responsive(
                          const SizedBox(),
                          lg: Expanded(
                            flex: 2,
                            child: parkOwnerTransaction.tableViewPaymentMethod(
                              context,
                            ),
                          ),
                        ),
                        if (context.isDesktop)
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                parkOwnerTransaction.status.chip(context),
                              ],
                            ),
                          ),
                        parkOwnerTransaction.amount.toCurrency(
                          context,
                          parkOwnerTransaction.currency,
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
