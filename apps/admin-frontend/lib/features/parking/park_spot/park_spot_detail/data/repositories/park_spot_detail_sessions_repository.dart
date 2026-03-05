import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_sessions.graphql.dart';

abstract class ParkSpotDetailSessionsRepository {
  Future<ApiResponse<Query$parkingLoginSessions>> getSessions({
    required String ownerId,
  });

  Future<ApiResponse<void>> terminateSession({required String sessionId});
}
