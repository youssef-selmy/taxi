import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/blocs/taxi_order_detail_transactions.cubit.dart';

class TaxiOrderFleetTransactions extends StatelessWidget {
  const TaxiOrderFleetTransactions({super.key});

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
                      context.tr.fleet,
                      style: context.textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      context.tr.total,
                      style: context.textTheme.labelMedium,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      (state.sumFleetTransactions).formatCurrency(
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
                  itemCount: state.fleetTransactions.isLoading
                      ? 2
                      : state.fleetTransactions.data!.length,
                  itemBuilder: (context, index) {
                    final fleetTransaction = state.fleetTransactions.isLoading
                        ? mockFleetTransaction1
                        : state.fleetTransactions.data!.elementAt(index);
                    return Row(
                      children: <Widget>[
                        Text(
                          fleetTransaction.transactionTimestamp.formatDateTime,
                          style: context.textTheme.labelMedium,
                        ),
                        const SizedBox(width: 18),
                        fleetTransaction.action.icon(context),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            fleetTransaction.action.name(context),
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [fleetTransaction.status.chip(context)],
                          ),
                        ),
                        fleetTransaction.amount.toCurrency(
                          context,
                          fleetTransaction.currency,
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
