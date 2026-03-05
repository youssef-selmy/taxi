import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/presentation/blocs/shop_order_detail_complaints.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ShopOrderDetailCustomerComplaints extends StatelessWidget {
  const ShopOrderDetailCustomerComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ShopOrderDetailComplaintsBloc,
      ShopOrderDetailComplaintsState
    >(
      builder: (context, state) {
        final complaintCustomers =
            state.shopOrderComplaintsState.data?.customerComplaints;
        return Skeletonizer(
          enabled: state.shopOrderComplaintsState.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.customer,
                  style: context.textTheme.headlineSmall,
                ),
                Column(
                  children:
                      (state.shopOrderComplaintsState.isLoading
                              ? mockShopOrderSupportRequests
                              : complaintCustomers!.nodes)
                          .map((complaintCustomer) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    complaintCustomer.subject,
                                    style: context.textTheme.labelMedium,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      complaintCustomer
                                          .createdAt
                                          .formatDateTime,
                                      style: context.textTheme.labelMedium,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      complaintCustomer.content ??
                                          context.tr.noContent,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.labelMedium
                                          ?.variant(context),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        complaintCustomer.status.chip(context),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  AppTextButton(
                                    onPressed: () {
                                      context.router.push(
                                        ShopSupportRequestDetailRoute(
                                          id: complaintCustomer.id,
                                        ),
                                      );
                                    },
                                    text: context.tr.viewDetails,
                                    suffixIcon: BetterIcons.arrowRight02Outline,
                                  ),
                                ],
                              ),
                            );
                          })
                          .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
