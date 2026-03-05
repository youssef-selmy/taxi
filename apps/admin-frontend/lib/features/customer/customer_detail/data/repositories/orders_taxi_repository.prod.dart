import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_taxi.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: OrdersTaxiRepository)
class OrdersTaxiRepositoryImpl implements OrdersTaxiRepository {
  final GraphqlDatasource graphQLDatasource;

  OrdersTaxiRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<String>> exportAll({
    required List<Input$OrderSort> sort,
    required Input$OrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final exportOrError = await graphQLDatasource.query(
      Options$Query$exportTaxiOrders(
        variables: Variables$Query$exportTaxiOrders(
          sorting: sort,
          filter: filter,
          format: format,
        ),
      ),
    );
    return exportOrError.mapData((data) => data.exportOrders);
  }
}
