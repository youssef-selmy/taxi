import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/graphql/parking_support_request.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/repositories/parking_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingSupportRequestRepository)
class ParkingSupportRequestRepositoryImpl
    implements ParkingSupportRequestRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingSupportRequestRepositoryImpl(this.graphQLDatasource);
  @override
  Future<ApiResponse<Query$parkingSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$ParkingSupportRequestFilter filter,
    required List<Input$ParkingSupportRequestSort> sorting,
  }) async {
    final getAllSupportRequest = await graphQLDatasource.query(
      Options$Query$parkingSupportRequests(
        variables: Variables$Query$parkingSupportRequests(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getAllSupportRequest;
  }
}
