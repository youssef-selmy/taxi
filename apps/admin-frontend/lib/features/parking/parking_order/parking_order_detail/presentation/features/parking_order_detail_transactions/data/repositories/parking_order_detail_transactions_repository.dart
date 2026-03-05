import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/graphql/parking_order_detail_transactions.graphql.dart';

abstract class ParkingOrderDetailTransactionsRepository {
  Future<ApiResponse<Query$parkingOrderTransactions>>
  getParkingOrderDetailTransactions({required String parkingOrderId});
}
