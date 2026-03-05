part of 'taxi_order_detail_transactions.cubit.dart';

@freezed
sealed class TaxiOrderDetailTransactionsState
    with _$TaxiOrderDetailTransactionsState {
  const factory TaxiOrderDetailTransactionsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getTaxiOrderDetailTransactions>
    taxiOrderTransactionsState,
  }) = _TaxiOrderDetailTransactionState;

  const TaxiOrderDetailTransactionsState._();

  ApiResponse<List<Fragment$customerTransaction>> get customerTransactions =>
      taxiOrderTransactionsState.mapData(
        (data) => data.order.riderTransactions,
      );

  ApiResponse<List<Fragment$driverTransaction>> get driverTransactions =>
      taxiOrderTransactionsState.mapData(
        (data) => data.order.driverTransactions,
      );

  ApiResponse<List<Fragment$providerTransaction>> get providerTransactions =>
      taxiOrderTransactionsState.mapData(
        (data) => data.order.providerTransactions,
      );

  ApiResponse<List<Fragment$fleetTransaction>> get fleetTransactions =>
      taxiOrderTransactionsState.mapData(
        (data) => data.order.fleetTransactions,
      );

  double get sumCustomerTransactions => customerTransactions.data == null
      ? 0
      : customerTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );

  double get sumDriverTransactions => driverTransactions.data == null
      ? 0
      : driverTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );

  double get sumProviderTransactions => providerTransactions.data == null
      ? 0
      : providerTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );

  double get sumFleetTransactions => fleetTransactions.data == null
      ? 0
      : fleetTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );
}
