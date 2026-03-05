part of 'reviews_parking.cubit.dart';

@freezed
sealed class ReviewsParkingState with _$ReviewsParkingState {
  const factory ReviewsParkingState({
    String? customerId,
    required ApiResponse<Query$customerParkingReviews> networkState,
    Input$OffsetPaging? paging,
  }) = _ReviewsParkingState;
}
