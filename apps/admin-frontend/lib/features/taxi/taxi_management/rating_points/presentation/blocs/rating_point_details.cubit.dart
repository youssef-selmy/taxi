import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_points_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'rating_point_details.state.dart';
part 'rating_point_details.cubit.freezed.dart';

class RatingPointDetailsBloc extends Cubit<RatingPointDetailsState> {
  final RatingPointsRepository _ratingPointsRepository =
      locator<RatingPointsRepository>();

  RatingPointDetailsBloc() : super(RatingPointDetailsState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      _fetchRatingPoint(id);
    } else {
      emit(
        state.copyWith(
          ratingPoint: const ApiResponse.loaded(null),
          name: null,
          isPositive: null,
        ),
      );
    }
  }

  void _fetchRatingPoint(String id) async {
    emit(state.copyWith(ratingPoint: const ApiResponse.loading()));
    final result = await _ratingPointsRepository.getRatingPoint(id: id);
    final networkState = result;
    emit(state.copyWith(ratingPoint: networkState));
  }

  void onSaved() {
    if (state.ratingPoint.data?.id != null) {
      _updateRatingPoint();
    } else {
      _createRatingPoint();
    }
  }

  void _updateRatingPoint() async {
    final result = await _ratingPointsRepository.updateRatingPoint(
      id: state.ratingPoint.data!.id,
      input: Input$FeedbackParameterInput(
        title: state.name!,
        isGood: state.isPositive!,
      ),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void _createRatingPoint() async {
    final result = await _ratingPointsRepository.createRatingPoint(
      input: Input$FeedbackParameterInput(
        title: state.name!,
        isGood: state.isPositive!,
      ),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onIsPositiveChanged(bool? isPositive) {
    emit(state.copyWith(isPositive: isPositive));
  }

  void onDeleted() async {
    if (state.ratingPoint.data?.id != null) {
      final result = await _ratingPointsRepository.deleteRatingPoint(
        state.ratingPoint.data!.id,
      );
      final networkState = result;
      emit(state.copyWith(networkStateSave: networkState));
    }
  }
}
