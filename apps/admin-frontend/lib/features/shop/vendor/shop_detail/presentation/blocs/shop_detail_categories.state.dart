part of 'shop_detail_categories.bloc.dart';

@freezed
sealed class ShopDetailCategoriesState with _$ShopDetailCategoriesState {
  const factory ShopDetailCategoriesState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopItemCategories> categoriesState,
    String? shopId,
    String? searchQuery,
    Fragment$Media? image,
    Input$OffsetPaging? paging,
  }) = _ShopDetailCategoriesState;
}
