part of 'orders_taxi.cubit.dart';

@freezed
sealed class OrdersTaxiState with _$OrdersTaxiState {
  const factory OrdersTaxiState({
    String? customerId,
    Input$PaginationInput? paging,
    @Default([]) List<Enum$TaxiOrderStatus> status,
    required Input$TaxiOrderSortInput sorting,
    @Default(ApiResponseInitial()) ApiResponse<Query$taxiOrders> ordersState,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _OrdersTaxiState;

  const OrdersTaxiState._();

  // initial
  factory OrdersTaxiState.initial() {
    return OrdersTaxiState(
      sorting: Input$TaxiOrderSortInput(id: Enum$SortOrder.DESC),
    );
  }

  Input$TaxiOrderFilterInput get filter =>
      Input$TaxiOrderFilterInput(riderId: customerId, status: status);
}
