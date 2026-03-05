import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/create_customer/data/graphql/create_customer.graphql.dart';
import 'package:admin_frontend/features/customer/create_customer/data/repositories/create_customer_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CreateCustomerRepository)
class CreateCustomerRepositoryImpl implements CreateCustomerRepository {
  final GraphqlDatasource graphQLDatasource;

  CreateCustomerRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Mutation$createCustomer>> createCustomer({
    String? firstName,
    String? lastName,
    String? email,
    String? countryCode,
    String? phoneNumber,
    Enum$Gender? gender,
  }) async {
    final mutationResult = await graphQLDatasource.mutate(
      Options$Mutation$createCustomer(
        variables: Variables$Mutation$createCustomer(
          input: Input$CreateOneRiderInput(
            rider: Input$RiderInput(
              firstName: firstName,
              lastName: lastName,
              email: email,
              countryIso: countryCode,
              mobileNumber: phoneNumber,
            ),
          ),
        ),
      ),
    );
    return mutationResult;
  }
}
