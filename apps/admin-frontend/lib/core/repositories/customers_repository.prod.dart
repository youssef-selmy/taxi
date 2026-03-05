import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/documents/select_customer.graphql.dart';
import 'package:admin_frontend/core/graphql/documents/select_location.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomersRepository)
class CustomerRepositoryProd implements CustomersRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerRepositoryProd(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$Customers>> getCustomers({
    required Input$OffsetPaging? paging,
    String? query,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$Customers(
        variables: Variables$Query$Customers(paging: paging, query: query),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<List<Fragment$Address>>> getCustomerAddresses({
    required String customerId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$CustomerAddresses(
        variables: Variables$Query$CustomerAddresses(customerId: customerId),
      ),
    );
    return result.mapData((r) => r.addresses.nodes.toList());
  }
}
