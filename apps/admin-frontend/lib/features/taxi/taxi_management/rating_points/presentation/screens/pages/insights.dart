import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_point_insights_repository.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/presentation/blocs/rating_points_insights.cubit.dart';

class RatingPointsInsights extends StatelessWidget {
  const RatingPointsInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingPointsInsightsBloc(),
      child: BlocBuilder<RatingPointsInsightsBloc, RatingPointsInsightsState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.ratingPointInsights.isLoading,
            child: ChartCard(
              title: context.tr.ratingPointPopularity,
              subtitle: context.tr.ratingPointPopularityByTimesUsed,
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: BarChartThin(
                  data:
                      (state.ratingPointInsights.data ??
                              mockRatingPointInsights)
                          .toChartSeriesData(),
                  bottomTitleBuilder: (data) => data.name,
                  leftTitleBuilder: (value) => value.toStringAsFixed(0),
                  leftReservedSize: 50,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
