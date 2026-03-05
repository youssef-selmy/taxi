import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_parking_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerComplaintsParkingRepository)
class CustomerComplaintsParkingRepositoryImpl
    implements CustomerComplaintsParkingRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerComplaintsParkingRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerComplaintsParking>>
  getCustomerComplaintsParking({
    required Input$OffsetPaging? paging,
    required Input$ParkingSupportRequestFilter filter,
    required List<Input$ParkingSupportRequestSort> sorting,
  }) async {
    final supportRequestsResponse = await graphQLDatasource.query(
      Options$Query$customerComplaintsParking(
        variables: Variables$Query$customerComplaintsParking(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return supportRequestsResponse;
  }
}
