import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/graphql/parking_order_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/repositories/parking_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingOrderListRepository)
class ParkingOrderListRepositoryImpl implements ParkingOrderListRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOrderListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingOrderList>> getParkingOrderList({
    required Input$OffsetPaging? paging,
    required Input$ParkOrderFilter filter,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    final getParkingOrderList = await graphQLDatasource.query(
      Options$Query$parkingOrderList(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$parkingOrderList(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getParkingOrderList;
  }

  @override
  Future<ApiResponse<Query$getParkingOrdersOverview>>
  getShopOrderStatistics() async {
    final overviewOrError = graphQLDatasource.query(
      Options$Query$getParkingOrdersOverview(),
    );
    return overviewOrError;
  }
}
