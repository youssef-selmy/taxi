import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_taxi.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerComplaintsTaxiRepository)
class CustomerComplaintsTaxiRepositoryImpl
    implements CustomerComplaintsTaxiRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerComplaintsTaxiRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerComplaintsTaxi>> getCustomerComplaintsTaxi({
    required Input$OffsetPaging? paging,
    required Input$TaxiSupportRequestFilter filter,
    required List<Input$TaxiSupportRequestSort> sorting,
  }) async {
    final supportRequestsResponse = await graphQLDatasource.query(
      Options$Query$customerComplaintsTaxi(
        variables: Variables$Query$customerComplaintsTaxi(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return supportRequestsResponse;
  }
}
