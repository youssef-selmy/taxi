import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/blocs/parking_order_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ParkingOrderDetailStartEndTime extends StatelessWidget {
  const ParkingOrderDetailStartEndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderDetailBloc, ParkingOrderDetailState>(
      builder: (context, state) {
        final parkingOrder = state.parkingOrderDetailState.isLoading
            ? mockParkingOrderDetail
            : state.parkingOrderDetailState.data;
        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: kBorder(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  BetterIcons.clock01Filled,
                  color: context.colors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${context.tr.from} ${parkingOrder?.enterTime.formatTime} | ${context.tr.to} ${parkingOrder?.exitTime.formatTime}',
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
