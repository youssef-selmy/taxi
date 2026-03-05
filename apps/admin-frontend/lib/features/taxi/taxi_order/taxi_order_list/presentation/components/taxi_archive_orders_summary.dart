import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_archive_list.cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/kpi_card/delta_text.dart';
import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_b.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class ArchiveOrdersSummary extends StatelessWidget {
  const ArchiveOrdersSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrdersArchiveListBloc, TaxiOrdersArchiveListState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.statistics.isLoading,
          child: LayoutGrid(
            columnSizes: context.responsive(
              [1.fr],
              lg: [1.fr, 1.fr, 1.fr, 1.fr],
            ),
            rowGap: 16,
            columnGap: 16,
            rowSizes: context.isDesktop
                ? [auto]
                : const [auto, auto, auto, auto],
            children: [
              KPICardStyleB(
                title: context.tr.totalRides,
                value: state.totalOrdersCount.toStringAsFixed(0),
                titleStyle: NumberCardTitleStyle.variant,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue: state.thisWeekOrdersCount.toDouble(),
                  previousValue: state.lastWeekOrdersCount.toDouble(),
                ),
              ),
              KPICardStyleB(
                title: context.tr.averageRideCost,
                value:
                    (state
                                .statistics
                                .data
                                ?.averageTotalRideCost
                                .firstOrNull
                                ?.avg
                                ?.costAfterCoupon ??
                            0)
                        .formatCurrency(Env.defaultCurrency),
                titleStyle: NumberCardTitleStyle.variant,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue:
                      state
                          .statistics
                          .data
                          ?.averageThisWeekRideCost
                          .firstOrNull
                          ?.avg
                          ?.costAfterCoupon ??
                      0,
                  previousValue:
                      state
                          .statistics
                          .data
                          ?.averageLastWeekRideCost
                          .firstOrNull
                          ?.avg
                          ?.costAfterCoupon ??
                      0,
                ),
              ),
              KPICardStyleB(
                title: context.tr.successRate,
                value:
                    "%${(state.statistics.data?.totalSuccessRate ?? 0).toStringAsFixed(1)}",
                titleStyle: NumberCardTitleStyle.variant,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue: state.statistics.data?.thisWeekSuccessRate ?? 0,
                  previousValue:
                      state.statistics.data?.lastWeekSuccessRate ?? 0,
                ),
              ),
              KPICardStyleB(
                title: context.tr.averageRideDuration,
                value: context.formatDurationFromSeconds(
                  state
                          .statistics
                          .data
                          ?.averageTotalRideDuration
                          .firstOrNull
                          ?.avg
                          ?.durationBest ??
                      0,
                ),
                titleStyle: NumberCardTitleStyle.variant,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue:
                      state
                          .statistics
                          .data
                          ?.averageThisWeekRideDuration
                          .firstOrNull
                          ?.avg
                          ?.durationBest ??
                      0,
                  previousValue:
                      state
                          .statistics
                          .data
                          ?.averageLastWeekRideDuration
                          .firstOrNull
                          ?.avg
                          ?.durationBest ??
                      0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
