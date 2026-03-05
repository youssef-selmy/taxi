import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/blocs/shop_order_detail_transactions.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/components/shop_order_customer_transaction.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/components/shop_order_driver_transaction.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/components/shop_order_provider_transaction.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/components/shop_order_shop_transaction.dart';

class ShopOrderDetailTransactionsScreen extends StatelessWidget {
  const ShopOrderDetailTransactionsScreen({super.key, required this.orderId});

  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopOrderDetailTransactionsBloc()..onStarted(orderId),
      child:
          BlocBuilder<
            ShopOrderDetailTransactionsBloc,
            ShopOrderDetailTransactionsState
          >(
            builder: (context, state) {
              final transaction = state.shopOrderTransactions.data;
              return SingleChildScrollView(
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: LargeHeader(
                          title: context.tr.walletTransactions,
                        ),
                      ),
                      const Divider(height: 1),

                      // riderTransactions
                      if (transaction?.shopOrder.riderTransactions.isNotEmpty ??
                          true) ...[
                        const ShopOrderCustomerTransaction(),
                        const SizedBox(height: 40),
                      ],

                      // driverTransactions
                      if (transaction
                              ?.shopOrder
                              .driverTransactions
                              .isNotEmpty ??
                          true) ...[
                        const DriverTransactionWidget(),
                        const SizedBox(height: 40),
                      ],

                      // shopTransactions
                      if (transaction?.shopOrder.shopTransactions.isNotEmpty ??
                          true) ...[
                        const ShopOrderShopTransaction(),
                        const SizedBox(height: 40),
                      ],

                      // providerTransactions
                      if (transaction
                              ?.shopOrder
                              .providerTransactions
                              .isNotEmpty ??
                          false) ...[
                        const ShopOrderProviderTransaction(),
                        const SizedBox(height: 40),
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
