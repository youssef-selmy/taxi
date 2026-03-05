import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/request_activity.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';

class TaxiOrderRideHistories extends StatelessWidget {
  const TaxiOrderRideHistories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
      builder: (context, state) {
        final activities =
            (state.orderDetailResponse.isLoading
                ? mockTaxiOrderActivitiesList
                : state.orderDetailResponse.data?.activities) ??
            [];
        if (activities.isEmpty) {
          return SizedBox();
        }
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: LargeHeader(title: context.tr.activities),
                ),
                Skeletonizer(
                  enabled: state.orderDetailResponse.isLoading,
                  enableSwitchAnimation: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: AppHorizontalStepIndicator(
                      items: activities
                          .map(
                            (e) => StepIndicatorItem(
                              label: e.type.toName(context),
                              description: e.createdAt.formatDateTime,
                              value: e.type,
                            ),
                          )
                          .followedBy(
                            activities.lastOrNull?.type.tripNextSteps.map(
                                  (e) => StepIndicatorItem(
                                    label: e.toName(context),
                                    value: e,
                                  ),
                                ) ??
                                [],
                          )
                          .toList(),
                      selectedStep: activities.isNotEmpty
                          ? activities.lastOrNull?.type
                          : null,
                    ),
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
