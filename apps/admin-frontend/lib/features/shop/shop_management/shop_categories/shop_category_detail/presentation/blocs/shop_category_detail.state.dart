part of 'shop_category_detail.bloc.dart';

@freezed
sealed class ShopCategoryDetailState with _$ShopCategoryDetailState {
  const factory ShopCategoryDetailState({
    @Default(ApiResponseInitial()) ApiResponse<void> shopCategoryState,
    String? shopCategoryId,
    String? name,
    String? description,
    Fragment$Media? image,
    Enum$ShopCategoryStatus? status,
    @Default(ApiResponseInitial()) ApiResponse<void> submitState,
  }) = _ShopCategoryDetailState;
}
