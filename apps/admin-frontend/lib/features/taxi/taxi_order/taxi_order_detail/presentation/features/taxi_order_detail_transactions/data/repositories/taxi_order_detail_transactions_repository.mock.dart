import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/graphql/taxi_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/repositories/taxi_order_detail_transactions_repository.dart';

@dev
@LazySingleton(as: TaxiOrderDetailTransactionsRepository)
class TaxiOrderDetailTransactionsRepositoryMock
    implements TaxiOrderDetailTransactionsRepository {
  @override
  Future<ApiResponse<Query$getTaxiOrderDetailTransactions>>
  getTaxiOrderTransactions({required String orderId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getTaxiOrderDetailTransactions(
        order: Query$getTaxiOrderDetailTransactions$order(
          currency: "USD",
          riderTransactions: mockCustomerTransactions,
          driverTransactions: mockDriverTransactionList,
          fleetTransactions: mockFleetTransactionList,
          providerTransactions: mockProviderTransactionList,
        ),
      ),
    );
  }
}
