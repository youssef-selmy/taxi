import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/park_spot_car_size.dart';
import 'package:admin_frontend/core/enums/park_spot_type.dart';
import 'package:admin_frontend/core/enums/parking_vehicle_type_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/blocs/parking_order_detail.cubit.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_calender.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_payment_method.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_start_end_time.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingOrderDetailBookingDetail extends StatelessWidget {
  const ParkingOrderDetailBookingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderDetailBloc, ParkingOrderDetailState>(
      builder: (context, state) {
        final parkingOrder = state.parkingOrderDetailState.isLoading
            ? mockParkingOrderDetail
            : state.parkingOrderDetailState.data;
        return switch (state.parkingOrderDetailState) {
          ApiResponseInitial() => const SizedBox(),
          ApiResponseError(:final message) => Text(message),
          ApiResponseLoading() || ApiResponseLoaded() => Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: kBorder(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Skeletonizer(
              enabled: state.parkingOrderDetailState.isLoading,
              enableSwitchAnimation: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: LargeHeader(title: context.tr.bookingDetails),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LayoutGrid(
                      columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                      rowGap: 16,
                      columnGap: 16,
                      rowSizes: const [auto, auto],
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 225,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: parkingOrder?.parkSpot.mainImage
                                      ?.widget(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 225,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    parkingOrder?.parkSpot.address ?? '',
                                    style: context.textTheme.titleMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            parkingOrder?.parkSpot.type.icon,
                                            color: context.colors.primary,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            parkingOrder?.parkSpot.type.name(
                                                  context,
                                                ) ??
                                                '',
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        (parkingOrder?.price ?? 0)
                                            .formatCurrency(
                                              parkingOrder?.currency ??
                                                  Env.defaultCurrency,
                                            ),
                                        style: context.textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        parkingOrder?.vehicleType.icon(),
                                        color: context.colors.primary,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      parkingOrder?.vehicleType ==
                                              Enum$ParkSpotVehicleType.Car
                                          ? Text(
                                              '${parkingOrder?.vehicleType.text(context)}, ${parkingOrder?.carSize?.text(context)}',
                                              style:
                                                  context.textTheme.bodyMedium,
                                            )
                                          : Text(
                                              parkingOrder?.vehicleType.text(
                                                    context,
                                                  ) ??
                                                  '',
                                              style:
                                                  context.textTheme.bodyMedium,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              context.responsive(
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ParkingOrderDetailCalender(),
                                    SizedBox(height: 8),
                                    ParkingOrderDetailStartEndTime(),
                                  ],
                                ),
                                lg: const Row(
                                  children: [
                                    ParkingOrderDetailCalender(),
                                    SizedBox(width: 8),
                                    ParkingOrderDetailStartEndTime(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 32),
                  const ParkingOrderDetailPaymentMethod(),
                ],
              ),
            ),
          ),
        };
      },
    );
  }
}
