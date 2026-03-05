part of 'zone_price_category_details.cubit.dart';

@freezed
sealed class ZonePriceCategoryDetailsState
    with _$ZonePriceCategoryDetailsState {
  const factory ZonePriceCategoryDetailsState({
    String? zonePriceCategoryId,
    String? name,
    required ApiResponse<Fragment$zonePriceCategory?> zonePriceCategory,
    required ApiResponse<void> networkStateSave,
  }) = _ZonePriceCategoryDetailsState;

  const ZonePriceCategoryDetailsState._();

  factory ZonePriceCategoryDetailsState.initial() =>
      ZonePriceCategoryDetailsState(
        zonePriceCategory: const ApiResponse.initial(),
        networkStateSave: const ApiResponse.initial(),
      );
}
