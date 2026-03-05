import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_orders.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_order.state.dart';
part 'fleet_order.cubit.freezed.dart';

class FleetOrderBloc extends Cubit<FleetOrderState> {
  final FleetOrdersRepository _fleetOrdersRepository =
      locator<FleetOrdersRepository>();

  FleetOrderBloc() : super(FleetOrderState.initial());

  void onStarted(String value) {
    onFleetIdChanged(value);
    _fetchFleetOrder();
  }

  Future<void> _fetchFleetOrder() async {
    emit(state.copyWith(fleetOrders: const ApiResponse.loading()));

    final result = await _fleetOrdersRepository.getFleetOrders(
      paging: state.paging,
      filter: Input$OrderFilter(
        fleetId: Input$IDFilterComparison(eq: state.fleetId),
        status: state.orderStatusFilter.isEmpty
            ? null
            : Input$OrderStatusFilterComparison($in: state.orderStatusFilter),
        paymentMode: state.paymentMethodFilter.isEmpty
            ? null
            : Input$PaymentModeFilterComparison($in: state.paymentMethodFilter),
      ),
      sorting: state.sortFields,
    );

    emit(state.copyWith(fleetOrders: result));
  }

  void onFleetIdChanged(String value) => emit(state.copyWith(fleetId: value));

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchFleetOrder();
  }

  void onSortingChanged(List<Input$OrderSort> value) {
    emit(state.copyWith(sortFields: value, paging: null));
    _fetchFleetOrder();
  }

  void onStatusChanged(List<Enum$OrderStatus> value) {
    emit(state.copyWith(orderStatusFilter: value, paging: null));
    _fetchFleetOrder();
  }

  void onPaymentModeChanged(List<Enum$PaymentMode> value) {
    emit(state.copyWith(paymentMethodFilter: value, paging: null));
    _fetchFleetOrder();
  }

  void export(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _fleetOrdersRepository.exportOrders(
      sort: state.sortFields,
      filter: state.filter,
      format: format,
    );
    emit(state.copyWith(exportState: exportOrError));
  }
}
