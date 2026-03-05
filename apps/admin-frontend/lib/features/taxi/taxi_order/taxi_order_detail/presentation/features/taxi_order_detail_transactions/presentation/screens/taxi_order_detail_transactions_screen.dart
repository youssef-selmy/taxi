import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/blocs/taxi_order_detail_transactions.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/components/taxi_order_customer_transactions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/components/taxi_order_driver_transactions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/components/taxi_order_fleet_transactions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/components/taxi_order_provider_transactions.dart';

class TaxiOrderDetailTransactionsScreen extends StatelessWidget {
  const TaxiOrderDetailTransactionsScreen({
    super.key,
    required this.taxiOrderId,
  });
  final String taxiOrderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaxiOrderDetailTransactionsBloc()..onStarted(taxiOrderId),
      child:
          BlocBuilder<
            TaxiOrderDetailTransactionsBloc,
            TaxiOrderDetailTransactionsState
          >(
            builder: (context, state) {
              final taxiOrderTransaction =
                  state.taxiOrderTransactionsState.data;
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: kBorder(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        child: LargeHeader(
                          title: context.tr.walletTransactions,
                        ),
                      ),
                      //customer
                      if (taxiOrderTransaction
                              ?.order
                              .riderTransactions
                              .isNotEmpty ??
                          true) ...[
                        const TaxiOrderCustomerTransactions(),
                        const SizedBox(height: 40),
                      ],
                      //Driver
                      if (taxiOrderTransaction
                              ?.order
                              .driverTransactions
                              .isNotEmpty ??
                          true) ...[
                        const TaxiOrderDriverTransactions(),
                        const SizedBox(height: 40),
                      ],

                      //Provider
                      if (taxiOrderTransaction
                              ?.order
                              .providerTransactions
                              .isNotEmpty ??
                          true) ...[
                        const TaxiOrderProviderTransactions(),
                        const SizedBox(height: 40),
                      ],

                      //fleet
                      if (taxiOrderTransaction
                              ?.order
                              .fleetTransactions
                              .isNotEmpty ??
                          false) ...[
                        const TaxiOrderFleetTransactions(),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
