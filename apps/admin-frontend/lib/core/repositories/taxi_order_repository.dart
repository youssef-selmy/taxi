import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';

abstract class TaxiOrderRepository {
  Future<ApiResponse<Query$taxiOrders>> getAll({
    required Input$TaxiOrderFilterInput filter,
    required Input$PaginationInput? paging,
    required Input$TaxiOrderSortInput? sorting,
  });

  Future<ApiResponse<Fragment$taxiOrderDetail>> getOne({
    required String orderId,
  });
}
