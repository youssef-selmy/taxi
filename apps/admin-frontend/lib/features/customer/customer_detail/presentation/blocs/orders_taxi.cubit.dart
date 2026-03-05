import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'orders_taxi.state.dart';
part 'orders_taxi.cubit.freezed.dart';

class OrdersTaxiBloc extends Cubit<OrdersTaxiState> {
  final OrdersTaxiRepository _ordersTaxiRepository =
      locator<OrdersTaxiRepository>();

  final TaxiOrderRepository _taxiOrderRepository =
      locator<TaxiOrderRepository>();

  OrdersTaxiBloc() : super(OrdersTaxiState.initial());

  void onStarted({required String customerId}) async {
    emit(state.copyWith(customerId: customerId));
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    emit(state.copyWith(ordersState: const ApiResponse.loading()));
    final result = await _taxiOrderRepository.getAll(
      filter: state.filter,
      paging: state.paging,
      sorting: state.sorting,
    );
    result.fold(
      (l, {failure}) => emit(state.copyWith(ordersState: ApiResponse.error(l))),
      (data) => emit(state.copyWith(ordersState: ApiResponse.loaded(data))),
    );
  }

  void onStatusChanged(List<Enum$TaxiOrderStatus> statuses) {
    emit(
      state.copyWith(
        status: statuses,
        paging: Input$PaginationInput(first: state.paging?.first, after: 0),
      ),
    );
    _fetchOrders();
  }

  void onSortingChanged(Input$TaxiOrderSortInput sorting) {
    emit(
      state.copyWith(
        sorting: sorting,
        paging: Input$PaginationInput(first: state.paging?.first, after: 0),
      ),
    );
    _fetchOrders();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(
      state.copyWith(
        paging: Input$PaginationInput(
          first: state.paging?.first,
          after: p1.offset,
        ),
      ),
    );
    _fetchOrders();
  }

  void export(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _ordersTaxiRepository.exportAll(
      sort: [],
      filter: Input$OrderFilter(),
      format: format,
    );
    emit(state.copyWith(exportState: exportOrError));
  }
}
