import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_sessions.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_sessions_repository.dart';

@prod
@LazySingleton(as: ParkSpotDetailSessionsRepository)
class ParkSpotDetailSessionsRepositoryImpl
    implements ParkSpotDetailSessionsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotDetailSessionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingLoginSessions>> getSessions({
    required String ownerId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$parkingLoginSessions(
        variables: Variables$Query$parkingLoginSessions(customerId: ownerId),
      ),
    );

    return result;
  }

  @override
  Future<ApiResponse<void>> terminateSession({
    required String sessionId,
  }) async {
    return ApiResponse.loaded(null);
  }
}
