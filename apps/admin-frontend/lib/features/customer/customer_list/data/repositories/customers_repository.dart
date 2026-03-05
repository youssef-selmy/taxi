import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/graphql/customers_statistics.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomersRepository {
  Future<ApiResponse<Fragment$CustomersListConnection>> getCustomers({
    Input$OffsetPaging? paging,
    Input$RiderFilter? filter,
    List<Input$RiderSort>? sorting,
  });

  Future<ApiResponse<Query$CustomersStatistics>> getCustomersStatistics();

  Future<ApiResponse<List<Fragment$RevenuePerApp>>> getRevenuePerApp({
    required Input$ChartFilterInput filter,
  });
}
