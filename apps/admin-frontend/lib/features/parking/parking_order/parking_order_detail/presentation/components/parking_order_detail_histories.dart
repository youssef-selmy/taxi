import 'package:flutter/material.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/blocs/parking_order_detail.cubit.dart';

class ParkingOrderDetailHistories extends StatelessWidget {
  const ParkingOrderDetailHistories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderDetailBloc, ParkingOrderDetailState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: LargeHeader(title: context.tr.orderHistory),
              ),
              const Divider(height: 1),
              Skeletonizer(
                enabled: state.parkingOrderDetailState.isLoading,
                enableSwitchAnimation: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:
                        (state.parkingOrderDetailState.isLoading
                                ? mockParkingOrderActivitiesList
                                : state
                                      .parkingOrderDetailState
                                      .data
                                      ?.activities)
                            ?.map(
                              (e) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: e.status.foregroundColor(
                                            context,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: context.colors.primary,
                                          ),
                                        ),
                                        child: Center(
                                          child: e.status.iconChip(context),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.status.name(context),
                                            style: context.textTheme.bodyMedium,
                                          ),
                                          Text(
                                            e.updatedAt?.formatDateTime ?? '',
                                            style: context.textTheme.labelMedium
                                                ?.variant(context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            .toList()
                            .separated(
                              separator: Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: DottedLine(
                                  dashColor: context.colors.outline,
                                  dashLength: 12,
                                  dashGapLength: 4,
                                  direction: Axis.vertical,
                                  lineLength: 48,
                                ),
                              ),
                            ) ??
                        [],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
