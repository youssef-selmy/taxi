import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_feedbacks.cubit.dart';

class ParkSpotDetailFeedbacksTab extends StatelessWidget {
  final String parkSpotId;

  const ParkSpotDetailFeedbacksTab({super.key, required this.parkSpotId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailFeedbacksBloc()..onStarted(parkSpotId: parkSpotId),
      child: BlocBuilder<ParkSpotDetailFeedbacksBloc, ParkSpotDetailFeedbacksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Reviews (${state.parkSpotFeedbacksState.data?.parkingFeedbacks.nodes.length ?? ""})",
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Skeletonizer(
                  enabled: state.parkSpotFeedbacksState.isLoading,
                  enableSwitchAnimation: true,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final feedback =
                          state
                              .parkSpotFeedbacksState
                              .data
                              ?.parkingFeedbacks
                              .nodes[index] ??
                          mockParkingFeedback1;
                      return feedback.toViewWithOrderRedirection(context);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount:
                        state
                            .parkSpotFeedbacksState
                            .data
                            ?.parkingFeedbacks
                            .nodes
                            .length ??
                        5,
                  ),
                ),
              ),
              const SizedBox(height: 120),
            ],
          );
        },
      ),
    );
  }
}
