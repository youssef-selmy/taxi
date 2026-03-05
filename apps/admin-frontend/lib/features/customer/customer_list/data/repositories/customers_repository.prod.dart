import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/graphql/customers.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/graphql/customers_statistics.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomersRepository)
class CustomersRepositoryImpl implements CustomersRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomersRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$CustomersListConnection>> getCustomers({
    Input$OffsetPaging? paging,
    Input$RiderFilter? filter,
    List<Input$RiderSort>? sorting,
  }) async {
    final customers = await graphQLDatasource.query(
      Options$Query$customersList(
        variables: Variables$Query$customersList(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return customers.mapData((response) => response.customers);
  }

  @override
  Future<ApiResponse<Query$CustomersStatistics>> getCustomersStatistics() {
    final year = DateTime.now().year;
    return graphQLDatasource.query(
      Options$Query$CustomersStatistics(
        variables: Variables$Query$CustomersStatistics(
          filter: Input$ChartFilterInput(
            interval: Enum$ChartInterval.Monthly,
            startDate: DateTime(year),
            endDate: DateTime(year + 1),
          ),
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>> getRevenuePerApp({
    required Input$ChartFilterInput filter,
  }) async {
    final revenuePerApp = await graphQLDatasource.query(
      Options$Query$revenuePerApp(
        variables: Variables$Query$revenuePerApp(filter: filter),
      ),
    );
    return revenuePerApp.mapData((response) => response.revenuePerApp);
  }
}
