import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/address.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/address_repository.dart';

@prod
@LazySingleton(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final GraphqlDatasource graphQLDatasource;

  AddressRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerAddresses>> getCustomerAddresses(
    String customerId,
  ) async {
    final addresses = await graphQLDatasource.query(
      Options$Query$customerAddresses(
        variables: Variables$Query$customerAddresses(customerId: customerId),
      ),
    );
    return addresses;
  }
}
