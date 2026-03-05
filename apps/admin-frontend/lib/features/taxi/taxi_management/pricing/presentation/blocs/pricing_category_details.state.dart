part of 'pricing_category_details.cubit.dart';

@freezed
sealed class PricingCategoryDetailsState with _$PricingCategoryDetailsState {
  const factory PricingCategoryDetailsState({
    String? pricingCategoryId,
    String? name,
    @Default(ApiResponse<Fragment$taxiPricingCategory?>.initial())
    ApiResponse<Fragment$taxiPricingCategory?> remoteData,
    @Default(ApiResponse<void>.initial()) ApiResponse<void> networkStateSave,
  }) = _PricingCategoryDetailsState;
}
