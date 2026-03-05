part of 'parking_order_detail_transactions.cubit.dart';

@freezed
sealed class ParkingOrderDetailTransactionsState
    with _$ParkingOrderDetailTransactionsState {
  const factory ParkingOrderDetailTransactionsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingOrderTransactions> parkingOrderTransactionsState,
  }) = _ParkingOrderDetailTransactionsState;

  const ParkingOrderDetailTransactionsState._();

  ApiResponse<List<Fragment$parkingTransaction>> get parkingTransactions =>
      parkingOrderTransactionsState.mapData(
        (data) => data.parkingTransactions.nodes,
      );

  ApiResponse<List<Fragment$customerTransaction>> get customerTransactions =>
      parkingOrderTransactionsState.mapData(
        (data) => data.parkOrder.customerTransactions,
      );

  ApiResponse<List<Fragment$customerTransaction>> get parkOwnerTransactions =>
      parkingOrderTransactionsState.mapData(
        (data) => data.parkOrder.parkOwnerTransactions,
      );

  ApiResponse<List<Fragment$providerTransaction>> get providerTransactions =>
      parkingOrderTransactionsState.mapData(
        (data) => data.parkOrder.providerTransactions,
      );

  double get sumCustomerTransactions => customerTransactions.data == null
      ? 0
      : customerTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );

  double get sumParkOwnerTransactions => parkOwnerTransactions.data == null
      ? 0
      : parkOwnerTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );

  double get sumProviderTransactions => providerTransactions.data == null
      ? 0
      : providerTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );

  double get sumParkingTransactions => parkingTransactions.data == null
      ? 0
      : parkingTransactions.data!.fold(
          0,
          (previousValue, element) => previousValue + element.amount,
        );
}
