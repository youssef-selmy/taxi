import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/create_customer/data/graphql/create_customer.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CreateCustomerRepository {
  Future<ApiResponse<Mutation$createCustomer>> createCustomer({
    String? firstName,
    String? lastName,
    String? email,
    String? countryCode,
    String? phoneNumber,
    Enum$Gender? gender,
  });
}
