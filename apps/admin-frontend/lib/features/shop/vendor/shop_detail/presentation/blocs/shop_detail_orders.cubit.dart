import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_orders.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_orders.state.dart';
part 'shop_detail_orders.cubit.freezed.dart';

class ShopDetailOrdersBloc extends Cubit<ShopDetailOrdersState> {
  final ShopDetailOrdersRepository _shopDetailOrdersRepository =
      locator<ShopDetailOrdersRepository>();

  ShopDetailOrdersBloc() : super(ShopDetailOrdersState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchActiveOrders();
  }

  void onTabSelected(int value) {
    emit(state.copyWith(selectedTab: value));
    if (value == 0) {
      _fetchActiveOrders();
    } else {
      _fetchHistoryOrders();
    }
  }

  Future<void> _fetchActiveOrders() async {
    emit(state.copyWith(activeOrdersState: const ApiResponse.loading()));
    final activeOrdersOrError = await _shopDetailOrdersRepository
        .getShopActiveOrders(shopId: state.shopId!);
    final activeOrdersState = activeOrdersOrError;
    emit(state.copyWith(activeOrdersState: activeOrdersState));
  }

  Future<void> _fetchHistoryOrders() async {
    emit(state.copyWith(ordersHistoryState: const ApiResponse.loading()));
    final historyOrdersOrError = await _shopDetailOrdersRepository
        .getShopOrders(
          filter: Input$ShopOrderFilter(
            status: state.statusFilter.isEmpty
                ? null
                : Input$ShopOrderStatusFilterComparison(
                    $in: state.statusFilter,
                  ),
          ),
          paging: state.historyPaging,
          sorting: state.sorting,
        );
    final historyOrdersState = historyOrdersOrError;
    emit(state.copyWith(ordersHistoryState: historyOrdersState));
  }

  void onStatusFilterChanged(List<Enum$ShopOrderStatus> selectedItems) {
    emit(state.copyWith(statusFilter: selectedItems));
    _fetchHistoryOrders();
  }

  void onHistoryPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(historyPaging: p1));
    _fetchHistoryOrders();
  }
}
