import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/presentation/blocs/parking_order_detail_complaints.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ParkingOrderDetailComplaintScreen extends StatelessWidget {
  final String parkingOrderId;

  const ParkingOrderDetailComplaintScreen({
    super.key,
    @PathParam('parkingOrderId') required this.parkingOrderId,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkingOrderDetailComplaintsBloc()..onStarted(parkingOrderId),
      child:
          BlocBuilder<
            ParkingOrderDetailComplaintsBloc,
            ParkingOrderDetailComplaintsState
          >(
            builder: (context, state) {
              final complaints = state
                  .parkingOrderComplaintsState
                  .data
                  ?.parkingOrderComplaints
                  .nodes;
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: kBorder(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      child: LargeHeader(title: context.tr.supportRequests),
                    ),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    Skeletonizer(
                      enabled: state.parkingOrderComplaintsState.isLoading,
                      enableSwitchAnimation: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr.customer,
                              style: context.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 16),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  (state.parkingOrderComplaintsState.isLoading
                                          ? mockParkingOrderSupportRequestList
                                          : complaints!)
                                      .map((customerComplaint) {
                                        return Row(
                                          children: <Widget>[
                                            Text(
                                              customerComplaint.subject,
                                              style:
                                                  context.textTheme.labelMedium,
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                customerComplaint
                                                    .createdAt
                                                    .toTimeAgo,
                                                style: context
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            ...context.responsive(
                                              [],
                                              lg: [
                                                Expanded(
                                                  child: Text(
                                                    customerComplaint.content ??
                                                        context.tr.noContent,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .textTheme
                                                        .labelMedium
                                                        ?.variant(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  customerComplaint.status.chip(
                                                    context,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            AppTextButton(
                                              text: context.tr.viewDetails,
                                              onPressed: () {
                                                context.router.push(
                                                  ParkingOrderDetailRoute(
                                                    parkingOrderId:
                                                        customerComplaint.id,
                                                  ),
                                                );
                                              },
                                              suffixIcon: BetterIcons
                                                  .arrowRight02Outline,
                                            ),
                                          ],
                                        );
                                      })
                                      .toList()
                                      .separated(
                                        separator: const SizedBox(height: 32),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
