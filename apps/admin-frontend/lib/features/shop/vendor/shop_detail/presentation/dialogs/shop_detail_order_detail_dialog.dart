import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/atoms/info_tile/info_tile.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_order_detail_dialog.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailOrderDetailDialog extends StatelessWidget {
  final String orderId;
  final String shopId;

  const ShopDetailOrderDetailDialog({
    super.key,
    required this.orderId,
    required this.shopId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopDetailOrderDetailDialogBloc()..onStarted(orderId: orderId),
      child: BlocBuilder<ShopDetailOrderDetailDialogBloc, ShopDetailOrderDetailDialogState>(
        builder: (context, state) {
          return AppResponsiveDialog(
            maxWidth: 700,
            icon: BetterIcons.informationCircleFilled,
            title: context.tr.orderDetails,
            primaryButton: AppOutlinedButton(
              onPressed: () {
                context.router.popAndPush(
                  ShopOrderDetailRoute(shopOrderId: state.orderState.data!.id),
                );
              },
              text: context.tr.viewDetails,
              suffixIcon: BetterIcons.arrowRight02Outline,
            ),
            child: switch (state.orderState) {
              ApiResponseLoaded(:final data) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: data.customer.tableView(
                          context,
                          showTitle: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      data.deliveryAddress.tableView(context),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      InfoTile(
                        isLoading: false,
                        iconData: BetterIcons.calendar04Filled,
                        data: data.createdAt.formatDateTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${context.tr.orderDetails}:",
                    style: context.textTheme.bodyMedium?.variant(context),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: kBorder(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              BetterIcons.creditCardFilled,
                              color: context.colors.onSurfaceVariant,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              context.tr.orderItems,
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "(${data.carts.firstWhere((cart) => cart.shop.id == shopId).products.length} ${context.tr.items})",
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ...data.carts
                                .firstWhere((cart) => cart.shop.id == shopId)
                                .products
                                .map(
                                  (cartItem) => Row(
                                    children: [
                                      if (cartItem.itemVariant?.product.image !=
                                          null) ...[
                                        cartItem.itemVariant!.product.image!
                                            .roundedWidget(size: 90, radius: 4),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartItem
                                                        .itemVariant
                                                        ?.product
                                                        .name ??
                                                    "-",
                                                style: context
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Text(
                                                    context.tr.variant,
                                                    style: context
                                                        .textTheme
                                                        .labelMedium
                                                        ?.variant(context),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    cartItem
                                                            .itemVariant
                                                            ?.name ??
                                                        "-",
                                                    style: context
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              ...cartItem.options
                                                  .map(
                                                    (option) => Row(
                                                      children: [
                                                        Text(
                                                          option.name,
                                                          style: context
                                                              .textTheme
                                                              .labelMedium
                                                              ?.variant(
                                                                context,
                                                              ),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          "+${option.price.formatCurrency(data.currency)}",
                                                          style: context
                                                              .textTheme
                                                              .labelMedium
                                                              ?.apply(
                                                                color: context
                                                                    .colors
                                                                    .primary,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList()
                                                  .separated(
                                                    separator: const SizedBox(
                                                      height: 4,
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Text(
                                          "${cartItem.priceEach.formatCurrency(data.currency)} x ${cartItem.quantity.toString()}",
                                          style: context.textTheme.bodyMedium
                                              ?.variant(context),
                                        ),
                                        const SizedBox(width: 24),
                                        Text(
                                          (cartItem.priceEach *
                                                  cartItem.quantity)
                                              .formatCurrency(data.currency),
                                          style: context.textTheme.bodyMedium,
                                        ),
                                      ],
                                    ],
                                  ),
                                )
                                .toList()
                                .separated(
                                  separator: const Divider(height: 16),
                                ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Text(
                                  context.tr.total,
                                  style: context.textTheme.bodyMedium,
                                ),
                                Spacer(),
                                Text(
                                  data.total.formatCurrency(data.currency),
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${context.tr.deliveryType}:",
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                            const SizedBox(height: 8),
                            data.paymentMethod.tableViewPaymentMethod(
                              context,
                              data.savedPaymentMethod,
                              data.paymentGateway,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${context.tr.paymentMethod}:",
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                            const SizedBox(height: 8),
                            data.paymentMethod.tableViewPaymentMethod(
                              context,
                              data.savedPaymentMethod,
                              data.paymentGateway,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _ => const SizedBox(),
            },
          );
        },
      ),
    );
  }
}
