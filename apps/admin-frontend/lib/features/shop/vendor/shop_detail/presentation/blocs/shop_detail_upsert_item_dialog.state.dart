part of 'shop_detail_upsert_item_dialog.bloc.dart';

@freezed
sealed class ShopDetailUpsertItemDialogState
    with _$ShopDetailUpsertItemDialogState {
  const factory ShopDetailUpsertItemDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopItemListItem?> itemState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$shopItemCategoryListItem>> categoriesState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$shopItemPresetListItem>> presetsState,
    String? shopId,
    String? itemId,
    String? name,
    Fragment$Media? image,
    @Default([]) List<Fragment$ItemVariant?> variants,
    @Default([]) List<Fragment$ItemOption?> options,
    @Default([]) List<Input$WeekdayScheduleInput> availabilitySchedule,
    @Default([]) List<Fragment$shopItemCategoryListItem> selectedCategories,
    @Default([]) List<Fragment$shopItemPresetListItem> selectedPresets,
    @Default(ApiResponseInitial()) ApiResponse<void> submitState,
  }) = _ShopDetailUpsertItemDialogState;
}
