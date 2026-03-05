part of 'driver_detail_reviews.bloc.dart';

@freezed
sealed class DriverDetailReviewsState with _$DriverDetailReviewsState {
  const factory DriverDetailReviewsState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverReviews> driverReviewsState,
    String? driverId,
    Input$OffsetPaging? paging,
  }) = _DriverDetailReviewsState;
}
