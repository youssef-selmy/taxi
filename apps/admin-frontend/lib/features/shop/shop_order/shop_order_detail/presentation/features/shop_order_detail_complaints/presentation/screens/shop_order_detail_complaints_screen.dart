import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/presentation/blocs/shop_order_detail_complaints.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/presentation/components/shop_order_detail_customer_complaints.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/presentation/components/shop_order_detail_shop_complaints.dart';

class ShopOrderDetailComplaintsScreen extends StatelessWidget {
  final String shopOrderId;

  const ShopOrderDetailComplaintsScreen({super.key, required this.shopOrderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopOrderDetailComplaintsBloc()..onStarted(shopOrderId),
      child:
          BlocBuilder<
            ShopOrderDetailComplaintsBloc,
            ShopOrderDetailComplaintsState
          >(
            builder: (context, state) {
              final complaintCustomers =
                  state.shopOrderComplaintsState.data?.customerComplaints;
              final complaintsShop =
                  state.shopOrderComplaintsState.data?.shopComplaints;
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: kBorder(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: 440,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          child: LargeHeader(title: context.tr.supportRequests),
                        ),
                        const Divider(height: 1),
                        if (complaintCustomers?.nodes.isNotEmpty ?? true) ...[
                          const SizedBox(height: 16),
                          const ShopOrderDetailCustomerComplaints(),
                        ],
                        if (complaintsShop?.nodes.isNotEmpty ?? true) ...[
                          const SizedBox(height: 24),
                          const ShopOrderDetailShopComplaints(),
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
