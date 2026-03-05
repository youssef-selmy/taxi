import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';

class TaxiOrderRideDetailMap extends StatelessWidget {
  final EdgeInsets? padding;
  const TaxiOrderRideDetailMap({super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
      builder: (context, state) {
        final order = state.orderDetailResponse.data ?? mockOrdersItem1;
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AppGenericMap(
            onControllerReady: (controller) {
              if (order.waypoints.isNotEmpty) {
                controller.fitBounds(
                  order.waypoints
                      .map((e) => e.location.toLatLngLib())
                      .followedBy(order.directions.map((e) => e.toLatLngLib()))
                      .toList(),
                );
              }
            },
            polylines: [
              if (order.directions.isNotEmpty)
                PolyLineLayer(
                  points: order.directions.toLatLngList(),
                  width: 2,
                  gradientColors: [
                    context.colors.primary,
                    context.colors.secondary,
                  ],
                ),
            ],
            mode: MapViewMode.static,
            interactive: true,
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
            markers: order.waypoints
                .map((e) => e.location)
                .toList()
                .markers(
                  titles: List.generate(order.waypoints.length, (index) {
                    if (index == 0) {
                      return context.tr.pickup;
                    } else if (index == (order.waypoints.length) - 1) {
                      return context.tr.dropOff;
                    } else {
                      return '${context.tr.stop} $index';
                    }
                  }),
                  addresses: order.waypoints.map((e) => e.address).toList(),
                ),
          ),
        );
      },
    );
  }
}
