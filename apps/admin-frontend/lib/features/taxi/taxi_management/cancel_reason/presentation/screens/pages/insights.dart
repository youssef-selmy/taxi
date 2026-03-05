import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/enums/user_type.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_insights_repository.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/presentation/blocs/cancel_reason_insights.cubit.dart';

class CancelReasonsInsights extends StatelessWidget {
  const CancelReasonsInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CancelReasonInsightsBloc()..onStarted(),
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: BlocProvider(
              create: (context) => CancelReasonInsightsBloc(),
              child: BlocBuilder<CancelReasonInsightsBloc, CancelReasonInsightsState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state.insights.isLoading,
                    child: Row(
                      children: [
                        Expanded(
                          child: ChartCard(
                            title: context.tr.cancellationByUserType,
                            subtitle:
                                context.tr.cancellationByUserTypeTimesUsed,
                            footer: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    (state
                                                .insights
                                                .data
                                                ?.cancelReasonPopularityByUserType ??
                                            mockCancelReasonPopularityByUserTypes)
                                        .map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 12,
                                            ),
                                            child: ChartIndicator(
                                              color: e.userType.color(context),
                                              title:
                                                  "${e.userType.name(context)} (${e.count})",
                                            ),
                                          );
                                        })
                                        .toList(),
                              ),
                            ),
                            child: RingChart(
                              data:
                                  (state
                                              .insights
                                              .data
                                              ?.cancelReasonPopularityByUserType ??
                                          mockCancelReasonPopularityByUserTypes)
                                      .toChartSeriesData(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: ChartCard(
                            title: context.tr.popularityOfCancelReasons,
                            subtitle:
                                context.tr.popularityOfCancelReasonsByTimesUsed,
                            child: BarChartThin(
                              data:
                                  (state
                                              .insights
                                              .data
                                              ?.cancelReasonPopularityByName ??
                                          mockCancelReasonPopularityByNames)
                                      .toChartSeriesData(),
                              bottomTitleBuilder: (data) => data.name,
                              leftTitleBuilder: (value) =>
                                  value.toStringAsFixed(0),
                              leftReservedSize: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
