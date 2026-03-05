import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_sessions.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_sessions_repository.dart';

@dev
@LazySingleton(as: ShopDetailSessionsRepository)
class ShopDetailSessionsRepositoryMock implements ShopDetailSessionsRepository {
  @override
  Future<ApiResponse<Query$shopLoginSessions>> getSessions({
    required String ownerId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopLoginSessions(
        shopLoginSessions: [
          Query$shopLoginSessions$shopLoginSessions(
            id: "1",
            shopId: "1",
            sessionInfo: mockSessionInfo1,
          ),
          Query$shopLoginSessions$shopLoginSessions(
            id: "2",
            shopId: "2",
            sessionInfo: mockSessionInfo2,
          ),
          Query$shopLoginSessions$shopLoginSessions(
            id: "3",
            shopId: "3",
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
