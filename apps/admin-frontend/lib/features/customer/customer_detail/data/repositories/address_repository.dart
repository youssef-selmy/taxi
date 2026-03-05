import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/address.graphql.dart';

abstract class AddressRepository {
  Future<ApiResponse<Query$customerAddresses>> getCustomerAddresses(
    String customerId,
  );
}
