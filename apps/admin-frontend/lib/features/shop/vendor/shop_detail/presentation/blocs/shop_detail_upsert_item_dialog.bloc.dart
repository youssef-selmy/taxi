import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_categories_repository.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_items_repository.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_presets_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_upsert_item_dialog.state.dart';
part 'shop_detail_upsert_item_dialog.bloc.freezed.dart';

class ShopDetailUpsertItemDialogBloc
    extends Cubit<ShopDetailUpsertItemDialogState> {
  final ShopDetailItemsRepository _itemsRepository =
      locator<ShopDetailItemsRepository>();
  final ShopDetailCategoriesRepository _categoriesRepository =
      locator<ShopDetailCategoriesRepository>();
  final ShopDetailPresetsRepository _presetsRepository =
      locator<ShopDetailPresetsRepository>();

  ShopDetailUpsertItemDialogBloc() : super(ShopDetailUpsertItemDialogState());

  void onStarted({required String shopId, required String? itemId}) {
    emit(
      state.copyWith(
        shopId: shopId,
        itemId: itemId,
        itemState: itemId == null
            ? ApiResponse.loaded(null)
            : ApiResponse.loading(),
      ),
    );
    if (itemId != null) {
      _fetchItem();
    }
    _fetchCategories();
    _fetchPresets();
  }

  Future<void> _fetchItem() async {
    final itemOrError = await _itemsRepository.getShopItem(
      itemId: state.itemId!,
    );
    final itemState = itemOrError;
    emit(state.copyWith(itemState: itemState, name: itemState.data?.name));
  }

  Future<void> _fetchCategories() async {
    final categoriesOrError = await _categoriesRepository.getShopItemCategories(
      paging: Input$OffsetPaging(limit: 100, offset: 0),
      filter: Input$ItemCategoryFilter(
        shopId: Input$IDFilterComparison(eq: state.shopId),
      ),
      sorting: [],
    );
    final categoriesState = categoriesOrError;
    emit(
      state.copyWith(
        categoriesState: categoriesState.mapData(
          (data) => data.itemCategories.nodes,
        ),
      ),
    );
  }

  Future<void> _fetchPresets() async {
    final presetsOrError = await _presetsRepository.getShopPresets(
      paging: Input$OffsetPaging(limit: 100, offset: 0),
      filter: Input$ShopItemPresetFilter(
        shopId: Input$IDFilterComparison(eq: state.shopId),
      ),
      sorting: [],
    );
    final presetsState = presetsOrError;
    emit(
      state.copyWith(
        presetsState: presetsState.mapData(
          (data) => data.shopItemPresets.nodes,
        ),
      ),
    );
  }

  void onSubmit() {}

  void onCategoriesChanged(List<Fragment$shopItemCategoryListItem>? p1) {
    emit(state.copyWith(selectedCategories: p1 ?? []));
  }

  void onPresetsChanged(List<Fragment$shopItemPresetListItem>? p1) {
    emit(state.copyWith(selectedPresets: p1 ?? []));
  }

  void onNameChanged(String p1) {
    emit(state.copyWith(name: p1));
  }

  void onImageChanged(Fragment$Media? p1) {}

  void addVariant() {
    emit(
      state.copyWith(
        variants: [
          ...state.variants,
          Fragment$ItemVariant(id: '', name: '', price: 0),
        ],
      ),
    );
  }

  void removeVariant(int index) {
    emit(
      state.copyWith(
        variants: [
          ...state.variants.getRange(0, index),
          null,
          ...state.variants.getRange(index + 1, state.variants.length),
        ],
      ),
    );
  }

  void onVariantNameChanged(int index, String p0) {
    emit(
      state.copyWith(
        variants: [
          ...state.variants.getRange(0, index),
          state.variants[index]!.copyWith(name: p0),
          ...state.variants.getRange(index + 1, state.variants.length),
        ],
      ),
    );
  }

  void onVariantPriceChanged(int index, double? p0) {
    emit(
      state.copyWith(
        variants: [
          ...state.variants.getRange(0, index),
          state.variants[index]!.copyWith(price: p0),
          ...state.variants.getRange(index + 1, state.variants.length),
        ],
      ),
    );
  }

  void addOption() {
    emit(
      state.copyWith(
        options: [
          ...state.options,
          Fragment$ItemOption(id: '', name: '', price: 0),
        ],
      ),
    );
  }

  void onOptionNameChanged(int index, String p0) {
    emit(
      state.copyWith(
        options: [
          ...state.options.getRange(0, index),
          state.options[index]!.copyWith(name: p0),
          ...state.options.getRange(index + 1, state.options.length),
        ],
      ),
    );
  }

  void onOptionPriceChanged(int index, double? p0) {
    emit(
      state.copyWith(
        options: [
          ...state.options.getRange(0, index),
          state.options[index]!.copyWith(price: p0),
          ...state.options.getRange(index + 1, state.options.length),
        ],
      ),
    );
  }

  void removeOption(int index) {
    emit(
      state.copyWith(
        options: [
          ...state.options.getRange(0, index),
          null,
          ...state.options.getRange(index + 1, state.options.length),
        ],
      ),
    );
  }
}
