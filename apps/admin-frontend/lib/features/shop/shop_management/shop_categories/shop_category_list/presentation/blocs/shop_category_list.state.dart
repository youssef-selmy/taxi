part of 'shop_category_list.bloc.dart';

@freezed
sealed class ShopCategoryListState with _$ShopCategoryListState {
  const factory ShopCategoryListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopCategories> shopCategoriesState,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$ShopCategoryStatus> statusFilter,
    @Default([]) List<Input$ShopCategorySort> sort,
  }) = _ShopCategoryListState;
}
