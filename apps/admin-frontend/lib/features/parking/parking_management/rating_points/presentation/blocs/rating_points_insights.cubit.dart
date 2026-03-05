import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_point_insights_repository.dart';

part 'rating_points_insights.state.dart';
part 'rating_points_insights.cubit.freezed.dart';

class RatingPointsInsightsBloc extends Cubit<RatingPointsInsightsState> {
  final RatingPointInsightsRepository _ratingPointsInsightsRepository =
      locator<RatingPointInsightsRepository>();

  RatingPointsInsightsBloc()
    : super(
        RatingPointsInsightsState(
          ratingPointInsights: const ApiResponse.initial(),
        ),
      );

  void onStarted() async {
    emit(state.copyWith(ratingPointInsights: const ApiResponse.loading()));
    final result = await _ratingPointsInsightsRepository
        .getRatingPointInsights();
    final networkState = result;
    emit(state.copyWith(ratingPointInsights: networkState));
  }
}
