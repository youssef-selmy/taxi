part of 'fleet_order.cubit.dart';

@freezed
sealed class FleetOrderState with _$FleetOrderState {
  const factory FleetOrderState({
    required ApiResponse<Query$fleetOrders> fleetOrders,
    String? fleetId,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$OrderSort> sortFields,
    @Default([]) List<Enum$OrderStatus> orderStatusFilter,
    @Default([]) List<Enum$PaymentMode> paymentMethodFilter,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _FleetOrderState;

  const FleetOrderState._();

  factory FleetOrderState.initial() =>
      FleetOrderState(fleetOrders: const ApiResponse.initial());

  Input$OrderFilter get filter => Input$OrderFilter(
    fleetId: Input$IDFilterComparison(eq: fleetId),
    status: orderStatusFilter.isEmpty
        ? null
        : Input$OrderStatusFilterComparison($in: orderStatusFilter),
    paymentMode: paymentMethodFilter.isEmpty
        ? null
        : Input$PaymentModeFilterComparison($in: paymentMethodFilter),
  );
}
