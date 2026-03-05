import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/presentation/bloc/taxi_order_detail_complaints.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/presentation/components/taxi_order_customer_complaints.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/presentation/components/taxi_order_driver_complaints.dart';

class TaxiOrderDetailComplaintsScreen extends StatelessWidget {
  const TaxiOrderDetailComplaintsScreen({super.key, required this.taxiOrderId});

  final String taxiOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaxiOrderDetailComplaintsBloc()..onStarted(taxiOrderId),
      child:
          BlocBuilder<
            TaxiOrderDetailComplaintsBloc,
            TaxiOrderDetailComplaintsState
          >(
            builder: (context, state) {
              final complaint = state.complaintState.data;
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: kBorder(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        child: LargeHeader(title: context.tr.complaints),
                      ),
                      if (complaint
                              ?.taxiOrderSupportRequests
                              .nodes
                              .isNotEmpty ??
                          true) ...[
                        const TaxiOrderCusromerComplaints(),
                        const SizedBox(height: 24),
                      ],
                      if (complaint
                              ?.taxiOrderSupportRequests
                              .nodes
                              .isNotEmpty ??
                          true)
                        const TaxiOrderDriverComplaints(),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
