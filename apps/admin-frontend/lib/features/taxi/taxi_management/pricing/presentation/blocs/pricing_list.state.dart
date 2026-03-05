part of 'pricing_list.cubit.dart';

@freezed
sealed class PricingListState with _$PricingListState {
  const factory PricingListState({
    required ApiResponse<List<Fragment$taxiPricingCategory>> categories,
    required ApiResponse<List<Fragment$taxiPricingListItem>> pricings,
    String? categoryId,
    String? searchQuery,
    Input$OffsetPaging? paging,
  }) = _PricingListState;

  factory PricingListState.initial() => PricingListState(
    categories: const ApiResponse.initial(),
    pricings: const ApiResponse.initial(),
  );
}
