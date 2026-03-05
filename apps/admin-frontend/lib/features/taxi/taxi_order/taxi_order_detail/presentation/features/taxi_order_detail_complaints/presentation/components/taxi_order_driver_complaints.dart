import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/presentation/bloc/taxi_order_detail_complaints.cubit.dart';
import 'package:better_icons/better_icons.dart';

class TaxiOrderDriverComplaints extends StatelessWidget {
  const TaxiOrderDriverComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      TaxiOrderDetailComplaintsBloc,
      TaxiOrderDetailComplaintsState
    >(
      builder: (context, state) {
        final complaints = state.complaintState.data;
        return Skeletonizer(
          enabled: state.complaintState.isLoading,
          enableSwitchAnimation: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr.driver, style: context.textTheme.headlineSmall),
                const SizedBox(height: 8),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  shrinkWrap: true,
                  itemCount: state.complaintState.isLoading
                      ? 2
                      : complaints?.taxiOrderSupportRequests.nodes
                                .where((e) => e.requestedByDriver == true)
                                .toList()
                                .length ??
                            0,
                  itemBuilder: (context, index) {
                    final complaint = state.complaintState.isLoading
                        ? mockcomplaintTaxiListItem1
                        : complaints!.taxiOrderSupportRequests.nodes[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: <Widget>[
                          Text(
                            complaint.subject,
                            style: context.textTheme.labelMedium,
                          ),
                          const SizedBox(width: 24),
                          Text(
                            complaint.inscriptionTimestamp.formatDateTime,
                            style: context.textTheme.labelMedium,
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              complaint.content ?? context.tr.noContent,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                          ),
                          complaint.status.chip(context),
                          const SizedBox(width: 24),
                          AppTextButton(
                            text: context.tr.viewDetails,
                            onPressed: () {
                              context.router.push(
                                TaxiSupportRequestDetailRoute(id: complaint.id),
                              );
                            },
                            suffixIcon: BetterIcons.arrowRight02Outline,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
