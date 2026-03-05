import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';

@prod
@LazySingleton(as: TaxiOrderRepository)
class TaxiOrderRepositoryImpl implements TaxiOrderRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$taxiOrders>> getAll({
    required Input$TaxiOrderFilterInput filter,
    required Input$PaginationInput? paging,
    required Input$TaxiOrderSortInput? sorting,
  }) async {
    final orders = await graphQLDatasource.query(
      Options$Query$taxiOrders(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Query$taxiOrders(
          sorting: sorting,
          paging: paging,
          filter: filter,
        ),
      ),
    );
    return orders;
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderDetail>> getOne({
    required String orderId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$taxiOrderDetail(
        variables: Variables$Query$taxiOrderDetail(id: orderId),
      ),
    );
    return result.mapData((f) => f.taxiOrder);
  }
}
