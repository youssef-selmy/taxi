import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_categories_repository.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_presets_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_create_category_dialog.state.dart';
part 'shop_detail_create_category_dialog.bloc.freezed.dart';

class ShopDetailCreateCategoryDialogBloc
    extends Cubit<ShopDetailCreateCategoryDialogState> {
  final ShopDetailCategoriesRepository _categoriesRepository =
      locator<ShopDetailCategoriesRepository>();
  final ShopDetailPresetsRepository _presetsRepository =
      locator<ShopDetailPresetsRepository>();

  ShopDetailCreateCategoryDialogBloc()
    : super(ShopDetailCreateCategoryDialogState());

  void onStarted({required String shopId, required String? categoryId}) {
    emit(
      state.copyWith(
        shopId: shopId,
        categoryId: categoryId,
        categoryState: categoryId == null
            ? ApiResponse.loaded(null)
            : ApiResponse.loading(),
      ),
    );
    if (categoryId != null) {
      _fetchCategory();
    }
    _fetchPresets();
  }

  void _fetchPresets() async {
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

  void _fetchCategory() async {
    final categoryOrError = await _categoriesRepository.getShopItemCategory(
      id: state.categoryId!,
    );
    final categoryState = categoryOrError;
    emit(
      state.copyWith(
        categoryState: categoryState,
        name: categoryState.data?.name,
        selectedPresets: categoryState.data?.presets ?? [],
      ),
    );
  }

  void onSubmit() {
    if (state.categoryId == null) {
      _createCategory();
    } else {
      _updateCategory();
    }
  }

  void onNameChanged(String p1) => emit(state.copyWith(name: p1));

  void onPresetsChanged(List<Fragment$shopItemPresetListItem>? p1) =>
      emit(state.copyWith(selectedPresets: p1 ?? []));

  void onImageChanged(Fragment$Media? p1) {
    emit(state.copyWith(image: p1));
  }

  void _createCategory() async {
    emit(state.copyWith(submitState: const ApiResponse.loading()));
    final createOrError = await _categoriesRepository.createShopItemCategory(
      input: state.toCreateInput,
    );
    final submitState = createOrError;
    emit(state.copyWith(submitState: submitState));
  }

  void _updateCategory() async {
    emit(state.copyWith(submitState: const ApiResponse.loading()));
    final updateOrError = await _categoriesRepository.updateShopItemCategory(
      id: state.categoryId!,
      input: state.toUpdateInput,
    );
    final submitState = updateOrError;
    emit(state.copyWith(submitState: submitState));
  }
}
