import 'package:admin_frontend/core/features/view_on_map_dialog/view_on_map_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ShopOrderDetailCustomerAndShopDetailBox extends StatelessWidget {
  const ShopOrderDetailCustomerAndShopDetailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final shopOrder = state.shopOrderDetailState.data;
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Skeletonizer(
            enabled: state.shopOrderDetailState.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: LargeHeader(title: context.tr.customersShopDetails),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    context.tr.customer,
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: <Widget>[
                                      AppAvatar(
                                        imageUrl:
                                            shopOrder?.customer.media?.address,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        shopOrder?.customer.fullName ?? '',
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        BetterIcons.gps01Filled,
                                        color: context.colors.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            shopOrder?.deliveryAddress.title ??
                                                context.tr.title,
                                            style: context.textTheme.bodyMedium,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            shopOrder
                                                    ?.deliveryAddress
                                                    .details ??
                                                '',
                                            style: context.textTheme.labelMedium
                                                ?.variant(context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        BetterIcons.call02Filled,
                                        color: context.colors.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          launchUrl(
                                            Uri.parse(
                                              'tel:${shopOrder?.customer.mobileNumber}',
                                            ),
                                          );
                                        },
                                        minimumSize: Size(0, 0),
                                        child: Text(
                                          shopOrder?.customer.mobileNumber
                                                  .formatPhoneNumber(
                                                    shopOrder
                                                        .customer
                                                        .countryIso,
                                                  ) ??
                                              '',
                                          style: context.textTheme.labelMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              CupertinoButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    useSafeArea: false,
                                    builder: (context) {
                                      return ViewOnMapDialog(
                                        latLng: shopOrder!
                                            .carts
                                            .first
                                            .shop
                                            .location!
                                            .toLatLngLib(),
                                        title: shopOrder.carts.first.shop.name,
                                        subtitle:
                                            shopOrder.carts.first.shop.address,
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      context.tr.viewOnMap,
                                      style: context.textTheme.labelMedium
                                          ?.apply(
                                            color: context.colors.primary,
                                          ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      BetterIcons.arrowRight02Outline,
                                      color: context.colors.primary,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 32),
                ),
                if (shopOrder != null && shopOrder.carts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          context.tr.shop,
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: shopOrder.carts.map((shop) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                  child: shop.shop.image.widget(
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  shop.shop.name,
                                                  style: context
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  BetterIcons.gps01Filled,
                                                  color: context.colors.primary,
                                                ),
                                                const SizedBox(width: 8),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      context.tr.location,
                                                      style: context
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      shop.shop.address ?? "-",
                                                      style: context
                                                          .textTheme
                                                          .labelMedium
                                                          ?.variant(context),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  BetterIcons.call02Filled,
                                                  color: context.colors.primary,
                                                ),
                                                const SizedBox(width: 8),
                                                CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    launchUrl(
                                                      Uri.parse(
                                                        'tel:${shopOrder.customer.mobileNumber}',
                                                      ),
                                                    );
                                                  },
                                                  minimumSize: Size(0, 0),
                                                  child: Text(
                                                    shopOrder
                                                        .customer
                                                        .mobileNumber
                                                        .formatPhoneNumber(
                                                          shopOrder
                                                              .customer
                                                              .countryIso,
                                                        ),
                                                    style: context
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CupertinoButton(
                                          onPressed: () {
                                            // TODO : Navigate to View on map
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                context.tr.viewOnMap,
                                                style: context
                                                    .textTheme
                                                    .labelMedium
                                                    ?.apply(
                                                      color: context
                                                          .colors
                                                          .primary,
                                                    ),
                                              ),
                                              const SizedBox(width: 4),
                                              Icon(
                                                BetterIcons.arrowRight02Outline,
                                                color: context.colors.primary,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
