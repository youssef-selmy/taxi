part of 'vendor_list.cubit.dart';

@freezed
sealed class VendorListState with _$VendorListState {
  const factory VendorListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$vendorCategories> vendorCategoriesState,
    @Default(ApiResponseInitial()) ApiResponse<Query$vendors> vendorsState,
    String? selectedShopCategoryId,
    String? searchQuery,
    @Default([]) List<Input$ShopSort> sorting,
    Input$OffsetPaging? paging,
  }) = _VendorListState;
}
