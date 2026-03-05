part of 'shop_detail_items.cubit.dart';

@freezed
sealed class ShopDetailItemsState with _$ShopDetailItemsState {
  const factory ShopDetailItemsState({
    @Default(ApiResponseInitial()) ApiResponse<Query$shopItems> itemsState,
    String? shopId,
    String? searchQuery,
    Input$OffsetPaging? paging,
  }) = _ShopDetailItemsState;
}
