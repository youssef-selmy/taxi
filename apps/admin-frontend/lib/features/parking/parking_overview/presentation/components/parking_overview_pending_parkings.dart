import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/header_tag.dart';
import 'package:admin_frontend/core/enums/park_spot_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_overview/presentation/blocs/parking_overview.bloc.dart';

class ParkingOverviewPendingParkings extends StatelessWidget {
  const ParkingOverviewPendingParkings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOverviewBloc, ParkingOverviewState>(
      builder: (context, state) {
        final data = state.pendingParkingsState.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.pendingParkings,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    HeaderTag(
                      text:
                          "${data?.parkSpots.totalCount ?? 0} ${context.tr.unverified}",
                    ),
                    Spacer(),
                    AppOutlinedButton(
                      onPressed: () {
                        context.router.push(ParkSpotListRoute());
                      },
                      color: SemanticColor.neutral,
                      text: context.tr.viewAll,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.pendingParkingsState.isLoading
                        ? 5
                        : data?.parkSpots.nodes.length ?? 0,
                    itemBuilder: (context, index) {
                      final parking = state.pendingParkingsState.isLoading
                          ? mockParkingListItem1
                          : data?.parkSpots.nodes[index];
                      if (parking == null) {
                        return const SizedBox();
                      }
                      return Row(
                        children: [
                          if (parking.mainImage != null) ...[
                            parking.mainImage!.roundedWidget(size: 40),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              parking.name ?? parking.address ?? "-",
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              parking.createdAt.toTimeAgo,
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [parking.status.toChip(context)],
                            ),
                          ),
                          const SizedBox(width: 16),
                          AppTextButton(
                            text: context.tr.viewProfile,
                            onPressed: () {
                              context.router.push(
                                ParkSpotDetailRoute(parkSpotId: parking.id),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 24),
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
