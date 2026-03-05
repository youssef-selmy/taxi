import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_sessions.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_sessions_repository.dart';

@dev
@LazySingleton(as: ParkSpotDetailSessionsRepository)
class ParkSpotDetailSessionsRepositoryMock
    implements ParkSpotDetailSessionsRepository {
  @override
  Future<ApiResponse<Query$parkingLoginSessions>> getSessions({
    required String ownerId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingLoginSessions(
        parkingLoginSessions: [
          Query$parkingLoginSessions$parkingLoginSessions(
            id: "1",
            customerId: "1",
            sessionInfo: mockSessionInfo1,
          ),
          Query$parkingLoginSessions$parkingLoginSessions(
            id: "2",
            customerId: "2",
            sessionInfo: mockSessionInfo2,
          ),
          Query$parkingLoginSessions$parkingLoginSessions(
            id: "3",
            customerId: "3",
            sessionInfo: mockSessionInfo3,
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<void>> terminateSession({
    required String sessionId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
