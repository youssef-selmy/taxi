import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/select_items.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/repositories/shop_dispatcher_repository.dart';

part 'select_items.state.dart';
part 'select_items.cubit.freezed.dart';

class SelectItemsBloc extends Cubit<SelectItemsState> {
  final ShopDispatcherRepository _shopDispatcherRepository =
      locator<ShopDispatcherRepository>();

  SelectItemsBloc() : super(SelectItemsState());

  void init({required String customerId, required String addressId}) async {
    emit(
      state.copyWith(
        shopCategories: const ApiResponse.loading(),
        shops: const ApiResponse.loading(),
        walletBalance: const ApiResponse.loading(),
        selectedAddressId: addressId,
        customerId: customerId,
      ),
    );
    final categories = await _shopDispatcherRepository.getShopCategories(
      customerId: customerId,
    );
    emit(
      state.copyWith(
        shopCategories: categories.mapData((r) => r.shopCategories.nodes),
        selectedShopCategoryId:
            categories.data?.shopCategories.nodes.firstOrNull?.id,
        walletBalance: ApiResponse.loaded(
          categories.data?.rider.wallet.firstOrNull ??
              Fragment$customerWallet(
                balance: 0,
                currency: Env.defaultCurrency,
              ),
        ),
      ),
    );
    _fetchShops();
  }

  void changeShopCategory({required String categoryId}) async {
    if (state.selectedShopCategoryId == categoryId) return;

    emit(state.copyWith(selectedShopCategoryId: categoryId));
    _fetchShops();
  }

  Future<void> _fetchShops() async {
    emit(state.copyWith(shops: const ApiResponse.loading()));
    final shops = await _shopDispatcherRepository.getShops(
      addressId: state.selectedAddressId!,
      categoryId: state.selectedShopCategoryId!,
      startIndex: 0,
      count: 10,
      query: null,
    );
    emit(state.copyWith(shops: shops.mapData((r) => r.dispatcherShops)));
  }

  void selectShop({required Fragment$DispatcherShop shop}) async {
    emit(state.copyWith(selectedShopId: shop.id, selectedItemCategoryId: null));
    final items = await _shopDispatcherRepository.getItems(
      shopId: shop.id,
      query: null,
    );
    emit(
      state.copyWith(
        items: items,
        selectedItemCategoryId: items.data?.firstOrNull?.id,
      ),
    );
  }

  void selectItemCategory({required String categoryId}) {
    emit(state.copyWith(selectedItemCategoryId: categoryId));
  }

  void goBackFromShop() {
    emit(
      state.copyWith(
        selectedShopId: null,
        items: const ApiResponse.initial(),
        selectedItemCategoryId: null,
      ),
    );
  }
}
