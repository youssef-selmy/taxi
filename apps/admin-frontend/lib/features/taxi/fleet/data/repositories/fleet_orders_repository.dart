import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_orders.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class FleetOrdersRepository {
  Future<ApiResponse<Query$fleetOrders>> getFleetOrders({
    required Input$OffsetPaging? paging,
    required Input$OrderFilter filter,
    required List<Input$OrderSort> sorting,
  });

  Future<ApiResponse<String>> exportOrders({
    required List<Input$OrderSort> sort,
    required Input$OrderFilter filter,
    required Enum$ExportFormat format,
  });
}
