import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/graphql/taxi_support_request.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/repositories/taxi_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: TaxiSupportRequestRepository)
class TaxiSupportRequestRepositoryImpl implements TaxiSupportRequestRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiSupportRequestRepositoryImpl(this.graphQLDatasource);
  @override
  Future<ApiResponse<Query$taxiSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$TaxiSupportRequestFilter filter,
    required List<Input$TaxiSupportRequestSort> sorting,
  }) async {
    final getAllSupportRequest = await graphQLDatasource.query(
      Options$Query$taxiSupportRequests(
        variables: Variables$Query$taxiSupportRequests(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getAllSupportRequest;
  }
}
