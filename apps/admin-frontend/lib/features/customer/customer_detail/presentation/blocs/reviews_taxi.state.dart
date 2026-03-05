part of 'reviews_taxi.cubit.dart';

@freezed
sealed class ReviewsTaxiState with _$ReviewsTaxiState {
  const factory ReviewsTaxiState({
    String? customerId,
    required ApiResponse<Query$customerTaxiReviews> networkState,
    Input$OffsetPaging? paging,
  }) = _ReviewsTaxiState;
}
