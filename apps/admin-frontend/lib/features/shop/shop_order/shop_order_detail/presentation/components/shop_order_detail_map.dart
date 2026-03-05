import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';

class ShopOrderDetailMap extends StatelessWidget {
  const ShopOrderDetailMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final order = state.shopOrderDetailState.data;
        return Expanded(
          child: SizedBox(
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppGenericMap(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 60,
                ),
                onControllerReady: (controller) {
                  if (order!.carts.isNotEmpty) {
                    final shopLocations = order.carts
                        .map((e) => e.shop.location!.toLatLngLib())
                        .toList();
                    final deliveryLocation = order.deliveryAddress.location
                        .toLatLngLib();
                    final bounds = [...shopLocations, deliveryLocation];
                    if (bounds.length > 1) {
                      controller.fitBounds(bounds);
                    }
                  }
                },
                polylines: [
                  PolyLineLayer(
                    points: order?.deliveryDirections?.toLatLngList() ?? [],
                    // points: [
                    //   ...List.generate(
                    //     order?.carts.length ?? 0,
                    //     (index) => LatLng(
                    //       order?.carts[index].shop.location.lat ?? 0,
                    //       order?.carts[index].shop.location.lng ?? 0,
                    //     ),
                    //   ),
                    //   LatLng(
                    //     order?.deliveryAddress.location.lat ?? 0,
                    //     order?.deliveryAddress.location.lng ?? 0,
                    //   ),
                    // ],
                    width: 2,
                    gradientColors: [
                      context.colors.primary,
                      context.colors.secondary,
                    ],
                  ),
                ],
                markers: [
                  ...order?.carts.map(
                        (cart) => AppRodMarker.marker(
                          id: cart.shop.id,
                          title: cart.shop.name,
                          position: cart.shop.location!.toLatLngLib(),
                          imageUrl: cart.shop.image?.address,
                        ),
                      ) ??
                      [],
                  if (order != null)
                    AppRodPin.marker(
                      id: order.deliveryAddress.id,
                      position: order.deliveryAddress.location.toLatLngLib(),
                      iconData: BetterIcons.gps01Filled,
                      color: SemanticColor.tertiary,
                    ),
                ],
                mode: MapViewMode.static,
                interactive: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
