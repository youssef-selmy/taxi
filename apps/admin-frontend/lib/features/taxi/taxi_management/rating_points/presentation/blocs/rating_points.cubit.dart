import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_points_repository.dart';

part 'rating_points.state.dart';
part 'rating_points.cubit.freezed.dart';

class RatingPointsBloc extends Cubit<RatingPointsState> {
  final RatingPointsRepository _ratingPointsRepository =
      locator<RatingPointsRepository>();

  RatingPointsBloc()
    : super(RatingPointsState(ratingPoints: const ApiResponse.initial()));

  void onStarted() {
    _fetchRatingPoints();
  }

  Future<void> _fetchRatingPoints() async {
    emit(state.copyWith(ratingPoints: const ApiResponse.loading()));
    final result = await _ratingPointsRepository.getRatingPoints();
    final networkState = result;
    emit(state.copyWith(ratingPoints: networkState));
  }
}
