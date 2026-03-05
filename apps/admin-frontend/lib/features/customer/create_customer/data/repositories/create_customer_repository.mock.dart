import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/customer/create_customer/data/graphql/create_customer.graphql.dart';
import 'package:admin_frontend/features/customer/create_customer/data/repositories/create_customer_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CreateCustomerRepository)
class CreateCustomerRepositoryMock implements CreateCustomerRepository {
  @override
  Future<ApiResponse<Mutation$createCustomer>> createCustomer({
    String? firstName,
    String? lastName,
    String? email,
    String? countryCode,
    String? phoneNumber,
    Enum$Gender? gender,
  }) async {
    return ApiResponse.loaded(
      Mutation$createCustomer(
        createOneRider: Mutation$createCustomer$createOneRider(id: "1"),
      ),
    );
  }
}
