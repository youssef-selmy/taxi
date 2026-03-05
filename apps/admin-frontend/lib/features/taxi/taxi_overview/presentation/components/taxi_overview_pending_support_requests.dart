import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/header_tag.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TaxiOverviewPendingSupportRequests extends StatelessWidget {
  const TaxiOverviewPendingSupportRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
      builder: (context, state) {
        final data = state.pendingSupportRequestsState.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.pendingSupportRequests,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    HeaderTag(
                      text:
                          "${data?.taxiSupportRequests.totalCount ?? 0} ${context.tr.unresolved}",
                    ),
                    Spacer(),
                    AppOutlinedButton(
                      onPressed: () {
                        context.router.push(TaxiSupportRequestListRoute());
                      },
                      color: SemanticColor.neutral,
                      text: context.tr.viewAll,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: switch (state.pendingDriversState) {
                    ApiResponseInitial() => const SizedBox(),
                    ApiResponseError() => AppEmptyState(
                      image: Assets.images.emptyStates.error,
                      title: context.tr.somethingWentWrong,
                      actionText: context.tr.retry,
                      onActionPressed: () {
                        context.read<TaxiOverviewBloc>().add(
                          TaxiOverviewEvent.pendingDriversRefresh(),
                        );
                      },
                    ),
                    ApiResponseLoading() || ApiResponseLoaded() => Skeletonizer(
                      enabled: state.pendingDriversState.isLoading,
                      enableSwitchAnimation: true,
                      child: _listView(
                        context,
                        state.pendingDriversState.isLoaded
                            ? (state
                                      .pendingSupportRequestsState
                                      .data
                                      ?.taxiSupportRequests
                                      .nodes ??
                                  [])
                            : List.generate(
                                4,
                                (_) => mockcomplaintTaxiListItem1,
                              ),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listView(
    BuildContext context,
    List<Fragment$taxiSupportRequest> items,
  ) {
    if (items.isEmpty) {
      return AppEmptyState(
        image: Assets.images.emptyStates.cyberThreat,
        title: context.tr.notEnoughDataToShow,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final supportRequest = items[index];
        return Row(
          children: [
            Expanded(
              child: Text(
                supportRequest.inscriptionTimestamp.toTimeAgo,
                style: context.textTheme.labelMedium,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [supportRequest.status.chip(context)],
              ),
            ),
            Expanded(
              child: supportRequest.assignedToStaffs
                  .map((staff) => staff.media)
                  .toList()
                  .avatarsView(
                    context: context,
                    totalCount: supportRequest.assignedToStaffs.length,
                    size: AvatarGroupSize.medium,
                  ),
            ),
            const SizedBox(width: 16),
            AppTextButton(
              text: context.tr.viewDetails,
              onPressed: () {
                context.router.push(
                  TaxiSupportRequestDetailRoute(id: supportRequest.id),
                );
              },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 24),
    );
  }
}
