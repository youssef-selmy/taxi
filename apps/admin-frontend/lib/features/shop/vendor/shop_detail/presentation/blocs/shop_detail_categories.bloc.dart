import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_categories_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_categories.state.dart';
part 'shop_detail_categories.bloc.freezed.dart';

class ShopDetailCategoriesBloc extends Cubit<ShopDetailCategoriesState> {
  final ShopDetailCategoriesRepository _categoriesRepository =
      locator<ShopDetailCategoriesRepository>();

  ShopDetailCategoriesBloc() : super(ShopDetailCategoriesState());

  void onStarted({required String shopId}) {
    emit(
      state.copyWith(shopId: shopId, categoriesState: ApiResponse.loading()),
    );
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    emit(state.copyWith(categoriesState: ApiResponse.loading()));
    final categoriesOrError = await _categoriesRepository.getShopItemCategories(
      paging: state.paging,
      filter: Input$ItemCategoryFilter(
        shopId: Input$IDFilterComparison(eq: state.shopId),
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: '%${state.searchQuery}%'),
      ),
      sorting: [],
    );
    final categoriesState = categoriesOrError;
    emit(state.copyWith(categoriesState: categoriesState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchCategories();
  }

  void onSearchQueryChanged(String p1) {
    emit(state.copyWith(searchQuery: p1));
    _fetchCategories();
  }

  Future<void> onDeletePressed({required String categoryId}) async {
    final deleteOrError = await _categoriesRepository.deleteShopItemCategory(
      id: categoryId,
    );
    if (deleteOrError.isLoaded) {
      _fetchCategories();
    }
  }
}
