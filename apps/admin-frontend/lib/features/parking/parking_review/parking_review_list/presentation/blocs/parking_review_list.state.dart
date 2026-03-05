part of 'parking_review_list.cubit.dart';

@freezed
sealed class ParkingReviewListState with _$ParkingReviewListState {
  const factory ParkingReviewListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingFeedbacks> parkingReviewsState,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ParkingFeedbackSort> sortFields,
    @Default([]) List<Enum$ReviewStatus> filterStatus,
    String? search,
  }) = _ParkingReviewListState;
}
