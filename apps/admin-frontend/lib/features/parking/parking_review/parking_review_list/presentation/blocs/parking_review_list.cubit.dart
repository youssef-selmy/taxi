import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/graphql/parking_review_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/repositories/parking_review_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_review_list.state.dart';
part 'parking_review_list.cubit.freezed.dart';

class ParkingReviewListBloc extends Cubit<ParkingReviewListState> {
  final ParkingReviewListRepository _parkingReviewListRepository =
      locator<ParkingReviewListRepository>();

  ParkingReviewListBloc() : super(ParkingReviewListState());

  void onStarted() {
    _fetchParkingReviewsList();
  }

  Future<void> _fetchParkingReviewsList() async {
    emit(state.copyWith(parkingReviewsState: const ApiResponse.loading()));

    final parkingReviewsListOrError = await _parkingReviewListRepository
        .getParkingReviewsList(
          paging: state.paging,
          filter: Input$ParkingFeedbackFilter(
            status: state.filterStatus.isEmpty
                ? null
                : Input$ReviewStatusFilterComparison($in: state.filterStatus),
          ),
          sorting: state.sortFields,
        );

    emit(state.copyWith(parkingReviewsState: parkingReviewsListOrError));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchParkingReviewsList();
  }

  void onSortingChanged(List<Input$ParkingFeedbackSort> value) {
    emit(state.copyWith(sortFields: value));
    _fetchParkingReviewsList();
  }

  void onStatusFilterChanged(List<Enum$ReviewStatus> value) {
    emit(state.copyWith(filterStatus: value));
    _fetchParkingReviewsList();
  }

  void onSearchFilterChanged(String value) {
    emit(state.copyWith(search: value));
    _fetchParkingReviewsList();
  }

  void updateFeedbackStatus({
    required String feedbackId,
    required Enum$ReviewStatus status,
  }) async {
    emit(state.copyWith(parkingReviewsState: const ApiResponse.loading()));

    final result = await _parkingReviewListRepository
        .updateParkingFeedbackStatus(id: feedbackId, status: status);
    if (result.isLoaded) {
      _fetchParkingReviewsList();
    }
  }
}
