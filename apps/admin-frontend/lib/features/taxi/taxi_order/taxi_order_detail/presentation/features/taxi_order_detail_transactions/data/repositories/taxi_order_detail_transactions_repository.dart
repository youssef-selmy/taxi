import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/graphql/taxi_order_detail_transactions.graphql.dart';

abstract class TaxiOrderDetailTransactionsRepository {
  Future<ApiResponse<Query$getTaxiOrderDetailTransactions>>
  getTaxiOrderTransactions({required String orderId});
}
