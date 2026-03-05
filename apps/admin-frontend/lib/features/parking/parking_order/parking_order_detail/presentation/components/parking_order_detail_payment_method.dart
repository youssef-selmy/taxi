import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/blocs/parking_order_detail.cubit.dart';

class ParkingOrderDetailPaymentMethod extends StatelessWidget {
  const ParkingOrderDetailPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderDetailBloc, ParkingOrderDetailState>(
      builder: (context, state) {
        final parkingOrder = state.parkingOrderDetailState.isLoading
            ? mockParkingOrderDetail
            : state.parkingOrderDetailState.data;
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.tr.paymentMethod}:',
                style: context.textTheme.labelMedium?.variant(context),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: kBorder(context),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: parkingOrder?.paymentGateway?.media.widget(
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    parkingOrder?.paymentGateway?.title ?? '',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 16),
                  parkingOrder!.status.toChip(context),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
