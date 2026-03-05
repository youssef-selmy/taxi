part of 'shop_detail_create_category_dialog.bloc.dart';

@freezed
sealed class ShopDetailCreateCategoryDialogState
    with _$ShopDetailCreateCategoryDialogState {
  const factory ShopDetailCreateCategoryDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopItemCategoryDetail?> categoryState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$shopItemPresetListItem>> presetsState,
    String? shopId,
    String? categoryId,
    String? name,
    Fragment$Media? image,
    @Default([]) List<Fragment$shopItemPresetListItem> selectedPresets,
    @Default(ApiResponseInitial()) ApiResponse<void> submitState,
  }) = _ShopDetailCreateCategoryDialogState;

  const ShopDetailCreateCategoryDialogState._();

  Input$CreateItemCategoryInput get toCreateInput =>
      Input$CreateItemCategoryInput(name: name!, shopId: shopId!);

  Input$UpdateItemCategoryInput get toUpdateInput =>
      Input$UpdateItemCategoryInput(name: name!);
}
