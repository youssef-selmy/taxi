part of 'select_items.cubit.dart';

@freezed
sealed class SelectItemsState with _$SelectItemsState {
  const factory SelectItemsState({
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$shopCategory>> shopCategories,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$DispatcherShop>> shops,
    @Default(ApiResponse.initial())
    ApiResponse<List<Query$items$shop$productCategories>> items,
    @Default(ApiResponse.initial())
    ApiResponse<Fragment$customerWallet> walletBalance,
    String? selectedShopCategoryId,
    String? selectedItemCategoryId,
    String? selectedShopId,
    String? selectedAddressId,
    String? customerId,
  }) = _SelectItemsState;

  const SelectItemsState._();

  Fragment$DispatcherShop? get selectedShop =>
      shops.data?.firstWhereOrNull((element) => element.id == selectedShopId);

  Fragment$shopCategory? get selectedShopCategory => shopCategories.data
      ?.firstWhereOrNull((element) => element.id == selectedShopCategoryId);

  Query$items$shop$productCategories? get selectedItemCategory =>
      items.data?.firstWhereOrNull(
        (element) => element.id == selectedItemCategoryId,
      ) ??
      items.data?.firstOrNull;
}
