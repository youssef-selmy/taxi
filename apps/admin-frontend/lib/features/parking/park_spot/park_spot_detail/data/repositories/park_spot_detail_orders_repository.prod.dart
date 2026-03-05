import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_orders.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkSpotDetailOrdersRepository)
class ParkSpotDetailOrdersRepositoryImpl
    implements ParkSpotDetailOrdersRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotDetailOrdersRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkSpotActiveOrders>> getParkSpotActiveOrders({
    required String parkSpotId,
  }) async {
    final ordersOrError = await graphQLDatasource.query(
      Options$Query$parkSpotActiveOrders(
        variables: Variables$Query$parkSpotActiveOrders(parkSpotId: parkSpotId),
      ),
    );
    return ordersOrError;
  }

  @override
  Future<ApiResponse<Query$parkSpotOrders>> getParkSpotOrders({
    required Input$ParkOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    final ordersOrError = await graphQLDatasource.query(
      Options$Query$parkSpotOrders(
        variables: Variables$Query$parkSpotOrders(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return ordersOrError;
  }

  @override
  Future<ApiResponse<Query$parkOrderDetail>> getOrderDetail({
    required String orderId,
  }) async {
    final orderDetailOrError = await graphQLDatasource.query(
      Options$Query$parkOrderDetail(
        variables: Variables$Query$parkOrderDetail(parkOrderId: orderId),
      ),
    );
    return orderDetailOrError;
  }
}
