part of 'zone_price_list.cubit.dart';

@freezed
sealed class ZonePriceListState with _$ZonePriceListState {
  const factory ZonePriceListState({
    required ApiResponse<List<Fragment$zonePriceCategory>> categories,
    required ApiResponse<Query$zonePrices> zonePrices,
    String? categoryId,
    String? searchQuery,
    Input$OffsetPaging? paging,
  }) = _ZonePriceListState;

  factory ZonePriceListState.initial() => ZonePriceListState(
    categories: const ApiResponse.initial(),
    zonePrices: const ApiResponse.initial(),
  );
}
