part of 'orders_parking.cubit.dart';

@freezed
sealed class OrdersParkingState with _$OrdersParkingState {
  const factory OrdersParkingState({
    String? customerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$ParkOrderStatus> statuses,
    @Default([]) List<Enum$PaymentMode> paymentModes,
    @Default([]) List<Input$ParkOrderSort> sorting,
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerOrdersParking> ordersState,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _OrdersParkingState;

  const OrdersParkingState._();

  Input$ParkOrderFilter get filter => Input$ParkOrderFilter(
    carOwnerId: Input$IDFilterComparison(eq: customerId),
    status: statuses.isEmpty
        ? null
        : Input$ParkOrderStatusFilterComparison($in: statuses),
    paymentMode: paymentModes.isEmpty
        ? null
        : Input$PaymentModeFilterComparison($in: paymentModes),
  );
}
