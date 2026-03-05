import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/atoms/info_tile/info_tile.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/payout_session_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/presentation/blocs/parking_payout_session_detail.cubit.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/presentation/components/driver_payout_session_detail_transactions.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/presentation/components/payout_method_tab_item.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_method_detail.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ParkingPayoutSessionDetailScreen extends StatelessWidget {
  final String? payoutSessionId;

  const ParkingPayoutSessionDetailScreen({
    super.key,
    @PathParam('id') this.payoutSessionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkingPayoutSessionDetailBloc()..onStarted(id: payoutSessionId!),
      child: SingleChildScrollView(
        child: Container(
          margin: context.pagePadding.copyWith(bottom: 0),
          color: context.colors.surface,
          child: Column(
            children: [
              PageHeader(title: context.tr.sessionDetail, showBackButton: true),
              const SizedBox(height: 16),
              BlocBuilder<
                ParkingPayoutSessionDetailBloc,
                ParkingPayoutSessionDetailState
              >(
                builder: (context, state) {
                  final session = state.payoutSessionDetailState.data;
                  return switch (state.payoutSessionDetailState) {
                    ApiResponseLoaded() || ApiResponseInitial() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                LayoutGrid(
                                  columnSizes: context.responsive(
                                    [1.fr],
                                    lg: [1.fr, 1.fr],
                                  ),
                                  rowSizes: context.responsive(
                                    [auto, auto],
                                    lg: [auto],
                                  ),
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${context.tr.session} #${session?.id}",
                                          style: context.textTheme.titleMedium,
                                        ),
                                        const SizedBox(width: 4),
                                        if (session != null) ...[
                                          AppDropdownStatus<
                                            Enum$PayoutSessionStatus
                                          >(
                                            items: Enum$PayoutSessionStatus
                                                .values
                                                .toStatusDropdownItems(context),
                                            onChanged: context
                                                .read<
                                                  ParkingPayoutSessionDetailBloc
                                                >()
                                                .onChangePayoutSessionStatus,
                                            initialValue: session.status,
                                          ),
                                        ],
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InfoTile(
                                          isLoading: state
                                              .payoutSessionDetailState
                                              .isLoading,
                                          iconData:
                                              BetterIcons.userMultipleFilled,
                                          data: session?.parkings.toString(),
                                        ),
                                        const SizedBox(width: 8),
                                        InfoTile(
                                          isLoading: state
                                              .payoutSessionDetailState
                                              .isLoading,
                                          iconData:
                                              BetterIcons.calendar04Filled,
                                          data:
                                              session?.createdAt.formatDateTime,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                LayoutGrid(
                                  columnSizes: context.responsive(
                                    [1.fr],
                                    lg: [1.fr, 1.fr, 1.fr],
                                  ),
                                  rowSizes: context.responsive(
                                    const [auto, auto, auto],
                                    lg: [auto],
                                  ),
                                  rowGap: 8,
                                  children: [
                                    Flex(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      direction: context.responsive(
                                        Axis.horizontal,
                                        lg: Axis.vertical,
                                      ),
                                      children: [
                                        Text(
                                          context.tr.totalAmount,
                                          style: context.textTheme.labelMedium
                                              ?.variant(context),
                                        ),
                                        context.responsive(
                                          const Spacer(),
                                          lg: const SizedBox(height: 8),
                                        ),
                                        (session?.totalAmount ?? 0).toCurrency(
                                          context,
                                          session?.currency ??
                                              Env.defaultCurrency,
                                        ),
                                      ],
                                    ),
                                    Flex(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      direction: context.responsive(
                                        Axis.horizontal,
                                        lg: Axis.vertical,
                                      ),
                                      children: [
                                        Text(
                                          "${context.tr.totalPaid}:",
                                          style: context.textTheme.labelMedium
                                              ?.variant(context),
                                        ),
                                        context.responsive(
                                          const Spacer(),
                                          lg: const SizedBox(height: 8),
                                        ),
                                        (session?.parkingsPaid ?? 0).toCurrency(
                                          context,
                                          session?.currency ??
                                              Env.defaultCurrency,
                                        ),
                                      ],
                                    ),
                                    Flex(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      direction: context.responsive(
                                        Axis.horizontal,
                                        lg: Axis.vertical,
                                      ),
                                      children: [
                                        Text(
                                          "${context.tr.totalPending}:",
                                          style: context.textTheme.labelMedium
                                              ?.variant(context),
                                        ),
                                        context.responsive(
                                          const Spacer(),
                                          lg: const SizedBox(height: 8),
                                        ),
                                        (session?.parkingsPending ?? 0)
                                            .toCurrency(
                                              context,
                                              session?.currency ??
                                                  Env.defaultCurrency,
                                            ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.tr.payoutMethod,
                          style: context.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        if (session != null)
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: session.payoutMethodDetails
                                .map(
                                  (e) => PayoutMethodTabItem(
                                    payoutMethod: e,
                                    selectedPayoutMethodId:
                                        state.selectedPayoutMethodId,
                                    onPayoutMethodSelected: context
                                        .read<ParkingPayoutSessionDetailBloc>()
                                        .onPayoutMethodSelected,
                                  ),
                                )
                                .toList(),
                          ),
                        const SizedBox(height: 24),
                        const PayoutMethodDetail(),
                        const SizedBox(height: 24),
                        const SizedBox(
                          height: 400,
                          child: ParkingPayoutSessionDetailTransactions(),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
