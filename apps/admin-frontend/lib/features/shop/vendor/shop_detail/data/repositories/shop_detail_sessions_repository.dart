import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_sessions.graphql.dart';

abstract class ShopDetailSessionsRepository {
  Future<ApiResponse<Query$shopLoginSessions>> getSessions({
    required String ownerId,
  });

  Future<ApiResponse<void>> terminateSession({required String sessionId});
}
