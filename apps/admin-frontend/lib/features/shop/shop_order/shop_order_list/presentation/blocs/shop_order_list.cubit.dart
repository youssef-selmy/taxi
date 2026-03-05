import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/graphql/shop_order_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/repositories/shop_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_order_list.state.dart';
part 'shop_order_list.cubit.freezed.dart';

class ShopOrderListBloc extends Cubit<ShopOrderListState> {
  final ShopOrderListRepository _shopOrderListRepository =
      locator<ShopOrderListRepository>();

  ShopOrderListBloc() : super(ShopOrderListState.initial());

  void onStarted() {
    _fetchShopCategories();
    _fetchStatistics();
    _fetchShopOrders();
  }

  Future<void> _fetchShopOrders() async {
    emit(state.copyWith(shopOrderList: const ApiResponse.loading()));

    final shopOrderListOrError = await _shopOrderListRepository.getShopOrders(
      paging: state.paging,
      filter: Input$ShopOrderFilter(
        status: state.shopOrderStatus.isEmpty
            ? null
            : Input$ShopOrderStatusFilterComparison($in: state.shopOrderStatus),
      ),
      sorting: state.sorting,
    );

    emit(state.copyWith(shopOrderList: shopOrderListOrError));
  }

  void _fetchStatistics() async {
    emit(state.copyWith(statistics: const ApiResponse.loading()));
    final statisticsOrError = await _shopOrderListRepository
        .getShopOrderStatistics();
    final statisticsState = statisticsOrError;
    emit(state.copyWith(statistics: statisticsState));
  }

  void _fetchShopCategories() async {
    emit(state.copyWith(shopCategories: const ApiResponse.loading()));
    final shopCategoriesOrError = await _shopOrderListRepository
        .getShopCategories();
    final shopCategoriesState = shopCategoriesOrError;
    emit(state.copyWith(shopCategories: shopCategoriesState));
  }

  void onSortingChanged(List<Input$ShopOrderSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchShopOrders();
  }

  void onStatusFilterChanged(List<Enum$ShopOrderStatus> statuses) {
    emit(state.copyWith(shopOrderStatus: statuses));
    _fetchShopOrders();
  }

  void onShopCategoryFilterChanged(
    List<Fragment$shopCategory> categoriesFilter,
  ) {
    emit(state.copyWith(listShopCategoryFilter: categoriesFilter));
    List<String> categoriesId = categoriesFilter.map((e) => e.id).toList();

    emit(state.copyWith(listShopCategoryFilterId: categoriesId));
    _fetchShopOrders();
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _fetchShopOrders();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchShopOrders();
  }

  void onTabChangedFilter(int index) {
    switch (index) {
      case 0:
        onStatusFilterChanged([]);

      case 1:
        onStatusFilterChanged([
          Enum$ShopOrderStatus.Processing,
          Enum$ShopOrderStatus.New,
        ]);

      case 2:
        onStatusFilterChanged([Enum$ShopOrderStatus.OutForDelivery]);

      case 3:
        onStatusFilterChanged([Enum$ShopOrderStatus.Completed]);

      case 4:
        onStatusFilterChanged([
          Enum$ShopOrderStatus.Cancelled,
          Enum$ShopOrderStatus.Returned,
        ]);

      case 5:
        onStatusFilterChanged([Enum$ShopOrderStatus.OnHold]);
    }
  }
}
