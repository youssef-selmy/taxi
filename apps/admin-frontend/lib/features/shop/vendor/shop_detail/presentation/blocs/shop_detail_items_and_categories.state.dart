part of 'shop_detail_items_and_categories.cubit.dart';

@freezed
sealed class ShopDetailItemsAndCategoriesState
    with _$ShopDetailItemsAndCategoriesState {
  const factory ShopDetailItemsAndCategoriesState({
    @Default(0) int selectedTab,
    required PageController pageController,
  }) = _ShopDetailItemsAndCategoriesState;

  const ShopDetailItemsAndCategoriesState._();

  // initial state
  factory ShopDetailItemsAndCategoriesState.initial() =>
      ShopDetailItemsAndCategoriesState(pageController: PageController());
}
