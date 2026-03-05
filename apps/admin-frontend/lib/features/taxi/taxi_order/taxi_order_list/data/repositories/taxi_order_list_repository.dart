import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/graphql/taxi_order_list.graphql.dart';

abstract class TaxiOrderListRepository {
  Future<ApiResponse<Query$getOrdersOverview>> getTaxiOrderStatistics();

  Future<ApiResponse<Query$fleets>> getFleets();
}
