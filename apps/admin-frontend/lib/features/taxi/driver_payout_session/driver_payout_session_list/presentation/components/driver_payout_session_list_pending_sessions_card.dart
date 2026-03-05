import 'package:admin_frontend/config/env.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/enums/payout_session_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/blocs/driver_payout_session_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

class DriverPayoutSessionListPendingSessionsCard extends StatelessWidget {
  const DriverPayoutSessionListPendingSessionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPayoutSessionListBloc>();
    return BlocBuilder<
      DriverPayoutSessionListBloc,
      DriverPayoutSessionListState
    >(
      builder: (context, state) {
        final isEmpty =
            (state
                    .pendingPayoutSessionsState
                    .data
                    ?.pendingSessions
                    .nodes
                    .isEmpty ??
                false) &&
            !state.pendingPayoutSessionsState.isLoading;
        return Card(
          child: isEmpty
              ? AppEmptyState(
                  image: Assets.images.emptyStates.error,
                  title: context.tr.noDataAvailable,
                )
              : Skeletonizer(
                  enabled: state.pendingPayoutSessionsState.isLoading,
                  enableSwitchAnimation: true,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        (state.selectedPendingPayoutSessionIndex +
                                                1)
                                            .toString(),
                                    style: context.textTheme.labelMedium,
                                  ),
                                  TextSpan(
                                    text:
                                        "/${state.pendingPayoutSessionsState.data?.pendingSessions.totalCount.toString()}",
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${context.tr.session} #${state.selectedPendingPayoutSession?.id}",
                              style: context.textTheme.labelMedium,
                            ),
                            const SizedBox(width: 8),
                            state.selectedPendingPayoutSession?.status.toChip(
                                  context,
                                ) ??
                                const AppTag(text: ""),
                            const Spacer(),
                            AppTextButton(
                              prefixIcon: BetterIcons.arrowLeft02Outline,
                              color: SemanticColor.neutral,
                              text: "",
                              onPressed: bloc.onPendingSessionsPreviousItem,
                            ),
                            AppTextButton(
                              prefixIcon: BetterIcons.arrowRight02Outline,
                              color: SemanticColor.neutral,
                              text: "",
                              onPressed: bloc.onPendingSessionsNextItem,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child:
                                  state
                                      .selectedPendingPayoutSession
                                      ?.driverTransactions
                                      .nodes
                                      .map(
                                        (transaction) =>
                                            transaction.driver?.media,
                                      )
                                      .nonNulls
                                      .toList()
                                      .avatarsView(
                                        context: context,
                                        totalCount:
                                            state
                                                .selectedPendingPayoutSession
                                                ?.driverTransactions
                                                .totalCount ??
                                            0,
                                        size: AvatarGroupSize.medium,
                                      ) ??
                                  const SizedBox(),
                            ),
                            Text(
                              (state
                                          .selectedPendingPayoutSession
                                          ?.totalAmount ??
                                      0)
                                  .formatCurrency(
                                    state
                                            .selectedPendingPayoutSession
                                            ?.currency ??
                                        Env.defaultCurrency,
                                  ),
                              style: context.textTheme.headlineMedium,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              state.selectedPendingPayoutSession?.currency ??
                                  Env.defaultCurrency,
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppFilledButton(
                          text: context.tr.processPayout,
                          onPressed: () {
                            context.router.push(
                              DriverPayoutSessionDetailRoute(
                                payoutSessionId:
                                    state.selectedPendingPayoutSession?.id,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
