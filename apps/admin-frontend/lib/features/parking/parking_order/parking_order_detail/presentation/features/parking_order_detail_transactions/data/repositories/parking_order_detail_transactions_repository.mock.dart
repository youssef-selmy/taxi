import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/graphql/parking_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/repositories/parking_order_detail_transactions_repository.dart';

@dev
@LazySingleton(as: ParkingOrderDetailTransactionsRepository)
class ParkingOrderDetailTransactionsRepositoryMock
    implements ParkingOrderDetailTransactionsRepository {
  @override
  Future<ApiResponse<Query$parkingOrderTransactions>>
  getParkingOrderDetailTransactions({required String parkingOrderId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingOrderTransactions(
        parkOrder: Query$parkingOrderTransactions$parkOrder(
          currency: "USD",
          parkOwnerTransactions: [
            mockCustomerTransaction1,
            mockCustomerTransaction2,
          ],
          providerTransactions: mockProviderTransactionList,
          customerTransactions: [
            mockCustomerTransaction3,
            mockCustomerTransaction4,
          ],
        ),
        parkingTransactions: Query$parkingOrderTransactions$parkingTransactions(
          nodes: mockParkingTransactions,
        ),
      ),
    );
  }
}
