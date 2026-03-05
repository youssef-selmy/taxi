import 'package:admin_frontend/config/env.dart';
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
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/blocs/shop_payout_session_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ShopPayoutSessionListPendingSessionsCard extends StatelessWidget {
  const ShopPayoutSessionListPendingSessionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopPayoutSessionListBloc>();
    return BlocBuilder<ShopPayoutSessionListBloc, ShopPayoutSessionListState>(
      builder: (context, state) {
        return Card(
          child: Skeletonizer(
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
                                  (state.selectedPendingPayoutSessionIndex + 1)
                                      .toString(),
                              style: context.textTheme.labelMedium,
                            ),
                            TextSpan(
                              text:
                                  "/${state.pendingPayoutSessionsState.data?.pendingSessions.totalCount.toString()}",
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Session #${state.selectedPendingPayoutSession?.id}",
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
                                ?.shopTransactions
                                .nodes
                                .map((transaction) => transaction.shop.image)
                                .nonNulls
                                .toList()
                                .avatarsView(
                                  context: context,
                                  totalCount:
                                      state
                                          .selectedPendingPayoutSession
                                          ?.shopTransactions
                                          .totalCount ??
                                      0,
                                  size: AvatarGroupSize.medium,
                                ) ??
                            const SizedBox(),
                      ),
                      Text(
                        (state.selectedPendingPayoutSession?.totalAmount ?? 0)
                            .formatCurrency(
                              state.selectedPendingPayoutSession?.currency ??
                                  Env.defaultCurrency,
                            ),
                        style: context.textTheme.headlineMedium,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.selectedPendingPayoutSession?.currency ??
                            Env.defaultCurrency,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppFilledButton(
                    text: context.tr.processPayout,
                    onPressed: () {
                      context.router.push(
                        ShopPayoutSessionDetailRoute(
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
