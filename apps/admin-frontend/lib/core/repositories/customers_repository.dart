import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/documents/select_customer.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomersRepository {
  Future<ApiResponse<Query$Customers>> getCustomers({
    required Input$OffsetPaging? paging,
    required String? query,
  });

  Future<ApiResponse<List<Fragment$Address>>> getCustomerAddresses({
    required String customerId,
  });
}
