import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_orders.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: FleetOrdersRepository)
class FleetOrdersRepositoryMock implements FleetOrdersRepository {
  @override
  Future<ApiResponse<Query$fleetOrders>> getFleetOrders({
    required Input$OffsetPaging? paging,
    required Input$OrderFilter filter,
    required List<Input$OrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleetOrders(
        orders: Query$fleetOrders$orders(
          nodes: mockFleetOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockFleetOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<String>> exportOrders({
    required List<Input$OrderSort> sort,
    required Input$OrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      "https://example.com/exported_orders.${format.name.toLowerCase()}",
    );
  }
}
