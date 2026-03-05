import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_cancel_order_button.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_delivery_type.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_items.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_map.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_payment_method.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_summary.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/dialogs/shop_order_detail_extended_dialog.dart';
import 'package:better_icons/better_icons.dart';

class ShopOrderDetailItem extends StatefulWidget {
  const ShopOrderDetailItem({super.key});

  @override
  State<ShopOrderDetailItem> createState() => _ShopOrderDetailItemState();
}

class _ShopOrderDetailItemState extends State<ShopOrderDetailItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final shopOrder = state.shopOrderDetailState.data;
        return Skeletonizer(
          enabled: state.shopOrderDetailState.isLoading,
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: kBorder(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            width: 6,
                            height: 16,
                            decoration: ShapeDecoration(
                              color: context.colors.onSurface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            context.tr.orderItems,
                            style: context.textTheme.titleMedium,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '(${state.itemsCount} ${context.tr.items})',
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.tr.allItemsDelivered,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                      context.responsive(
                        const SizedBox(),
                        lg: const ShopOrderDetailCancelOrderButton(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ShopOrderDetailMap()],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: context.colors.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    BetterIcons.clock01Filled,
                                    color: context.colors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${context.tr.estimateTime}:',
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                shopOrder?.estimatedDeliveryTime?.formatTime ??
                                    '',
                                style: context.textTheme.labelMedium,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                useSafeArea: false,
                                builder: (context) {
                                  return const ShopOrderDetailExtendedDialog();
                                },
                              );
                            },
                            child: Text(
                              context.tr.extended,
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const ShopOrderDetailItems(),
                const ShopOrderDetailSummarySection(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ...context.responsive(
                        const [
                          Row(
                            children: <Widget>[
                              ShopOrderDetailDeliveryType(),
                              SizedBox(width: 16),
                              ShopOrderDetailPaymentMethod(),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ShopOrderDetailCancelOrderButton(),
                              ),
                            ],
                          ),
                        ],
                        lg: const [
                          ShopOrderDetailDeliveryType(),
                          SizedBox(height: 16),
                          ShopOrderDetailPaymentMethod(),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
