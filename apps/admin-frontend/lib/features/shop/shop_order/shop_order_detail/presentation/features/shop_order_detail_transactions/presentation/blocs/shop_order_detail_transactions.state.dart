part of 'shop_order_detail_transactions.cubit.dart';

@freezed
sealed class ShopOrderDetailTransactionsState
    with _$ShopOrderDetailTransactionsState {
  const factory ShopOrderDetailTransactionsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getShopOrderTransactions> shopOrderTransactions,
  }) = _ShopOrderDetailTransactionsState;

  const ShopOrderDetailTransactionsState._();

  ApiResponse<List<Fragment$customerTransaction>> get customerTransactions =>
      shopOrderTransactions.mapData((data) => data.shopOrder.riderTransactions);

  ApiResponse<List<Fragment$driverTransaction>> get driverTransactions =>
      shopOrderTransactions.mapData(
        (data) => data.shopOrder.driverTransactions,
      );

  ApiResponse<
    List<Query$getShopOrderTransactions$shopOrder$providerTransactions>
  >
  get providerTransactions => shopOrderTransactions.mapData(
    (data) => data.shopOrder.providerTransactions,
  );

  ApiResponse<List<Query$getShopOrderTransactions$shopOrder$shopTransactions>>
  get shopTransactions =>
      shopOrderTransactions.mapData((data) => data.shopOrder.shopTransactions);

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

  List<double> get sumProviderTransactions {
    List<double> listSum = [];

    if (providerTransactions.data != null) {
      for (int i = 0; i < providerTransactions.data!.length; i++) {
        listSum.add(
          providerTransactions.data![i].providerTransactions.fold(
            0.0,
            (previousValue, element) => previousValue + element.amount,
          ),
        );
      }
    }

    return listSum;
  }

  List<double> get sumShopTransactions {
    List<double> listSum = [];

    if (shopTransactions.data != null) {
      for (int i = 0; i < shopTransactions.data!.length; i++) {
        listSum.add(
          shopTransactions.data![i].shopTransactions.fold(
            0.0,
            (previousValue, element) => previousValue + element.amount,
          ),
        );
      }
    }

    return listSum;
  }
}
