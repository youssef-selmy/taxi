import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_parking_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: OrdersParkingRepository)
class OrdersParkingRepositoryImpl implements OrdersParkingRepository {
  final GraphqlDatasource graphQLDatasource;

  OrdersParkingRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerOrdersParking>> getAll({
    required Input$ParkOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    final orders = await graphQLDatasource.query(
      Options$Query$customerOrdersParking(
        variables: Variables$Query$customerOrdersParking(
          sorting: sorting,
          paging: paging,
          filter: filter,
        ),
      ),
    );
    return orders;
  }

  @override
  Future<ApiResponse<String>> export({
    required List<Input$ParkOrderSort> sort,
    required Input$ParkOrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final exportUrl = await graphQLDatasource.query(
      Options$Query$exportParkingOrders(
        variables: Variables$Query$exportParkingOrders(
          sorting: sort,
          filter: filter,
          format: format,
        ),
      ),
    );
    return exportUrl.mapData((data) => data.exportParkOrders);
  }
}
