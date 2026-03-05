import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';

@dev
@LazySingleton(as: TaxiOrderRepository)
class TaxiOrderRepositoryMock implements TaxiOrderRepository {
  @override
  Future<ApiResponse<Query$taxiOrders>> getAll({
    required Input$TaxiOrderFilterInput filter,
    required Input$PaginationInput? paging,
    required Input$TaxiOrderSortInput? sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiOrders(
        taxiOrders: Query$taxiOrders$taxiOrders(
          edges: mockOrderTaxiListItems,
          pageInfo: Fragment$PageInfo(
            hasNextPage: false,
            hasPreviousPage: false,
          ),
          totalCount: mockOrderTaxiListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderDetail>> getOne({
    required String orderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return ApiResponse.loaded(mockOrdersItem1);
  }
}
