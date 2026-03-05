import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_items_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_items.state.dart';
part 'shop_detail_items.cubit.freezed.dart';

class ShopDetailItemsBloc extends Cubit<ShopDetailItemsState> {
  final ShopDetailItemsRepository _itemsRepository =
      locator<ShopDetailItemsRepository>();

  ShopDetailItemsBloc() : super(ShopDetailItemsState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    emit(state.copyWith(itemsState: ApiResponse.loading()));
    final itemsOrError = await _itemsRepository.getShopItems(
      paging: state.paging,
      filter: Input$ItemFilter(
        shopId: Input$IDFilterComparison(eq: state.shopId),
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: '%${state.searchQuery}%'),
      ),
      sorting: [],
    );
    final itemsState = itemsOrError;
    emit(state.copyWith(itemsState: itemsState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchItems();
  }

  Future<void> onDeletePressed({required String categoryId}) async {
    emit(state.copyWith(itemsState: ApiResponse.loading()));
    final deleteOrError = await _itemsRepository.deleteShopItem(
      itemId: categoryId,
    );
    if (deleteOrError.isLoaded) {
      _fetchItems();
    }
  }

  void onSearchQueryChanged(String p1) {
    emit(state.copyWith(searchQuery: p1));
    _fetchItems();
  }
}
