import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_shop_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'orders_shop.state.dart';
part 'orders_shop.cubit.freezed.dart';

class OrdersShopBloc extends Cubit<OrdersShopState> {
  final OrdersShopRepository _ordersShopRepository =
      locator<OrdersShopRepository>();

  OrdersShopBloc() : super(OrdersShopState());

  void onStarted({required String customerId}) async {
    emit(state.copyWith(customerId: customerId));
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    emit(state.copyWith(ordersState: const ApiResponse.loading()));
    final result = await _ordersShopRepository.getAll(
      customerId: state.customerId!,
      statuses: state.statuses,
      paymentModes: state.paymentModes,
      paging: state.paging,
      sorting: state.sorting,
    );
    emit(state.copyWith(ordersState: result));
  }

  void onStatusChanged(List<Enum$ShopOrderStatus> statuses) {
    emit(state.copyWith(statuses: statuses));
    _fetchOrders();
  }

  void onPaymentModeChanged(List<Enum$PaymentMode> paymentModes) {
    emit(state.copyWith(paymentModes: paymentModes));
    _fetchOrders();
  }

  void onSortingChanged(List<Input$ShopOrderSort> sorting) {
    emit(state.copyWith(sorting: sorting));
    _fetchOrders();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchOrders();
  }

  void export(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _ordersShopRepository.export(
      sort: state.sorting,
      filter: state.filter,
      format: format,
    );
    emit(state.copyWith(exportState: exportOrError));
  }
}
