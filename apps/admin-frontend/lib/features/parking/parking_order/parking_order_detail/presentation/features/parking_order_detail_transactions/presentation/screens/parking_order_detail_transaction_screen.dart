import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/blocs/parking_order_detail_transactions.cubit.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/components/parking_order_detail_customer_transactions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/components/parking_order_detail_park_owner_transactions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/components/parking_order_detail_parking_transactions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/components/parking_order_detail_provider_transactions.dart';

class ParkingOrderDetailTransactionScreen extends StatelessWidget {
  const ParkingOrderDetailTransactionScreen({
    super.key,
    required this.parkingOrderId,
  });

  final String parkingOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkingOrderDetailTransactionsBloc()..onStarted(parkingOrderId),
      child:
          BlocBuilder<
            ParkingOrderDetailTransactionsBloc,
            ParkingOrderDetailTransactionsState
          >(
            builder: (context, state) {
              final transaction = state.parkingOrderTransactionsState.data;
              return SingleChildScrollView(
                child: SafeArea(
                  top: false,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      border: Border.all(color: context.colors.outline),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          child: LargeHeader(title: context.tr.transactions),
                        ),
                        const Divider(height: 1),

                        //parkingTransaction
                        if (transaction?.parkingTransactions.nodes.isNotEmpty ??
                            true) ...[
                          const ParkingOrderDetailParkingTransactions(),
                          const SizedBox(height: 40),
                        ],

                        // customerTransactions
                        if (transaction
                                ?.parkOrder
                                .customerTransactions
                                .isNotEmpty ??
                            true) ...[
                          const ParkingOrderDetailCustomerTransactions(),
                          const SizedBox(height: 40),
                        ],

                        // parkOwnerTransactions
                        if (transaction
                                ?.parkOrder
                                .parkOwnerTransactions
                                .isNotEmpty ??
                            true) ...[
                          const ParkingOrderDetailParkOwnerTransactions(),
                          const SizedBox(height: 40),
                        ],

                        // providerTransactions
                        if (transaction
                                ?.parkOrder
                                .providerTransactions
                                .isNotEmpty ??
                            false) ...[
                          const ParkingOrderDetailProviderTransactions(),
                          const SizedBox(height: 24),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
