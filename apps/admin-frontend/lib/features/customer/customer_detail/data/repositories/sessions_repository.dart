import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_session.graphql.dart';

abstract class SessionsRepository {
  Future<ApiResponse<List<Fragment$customerSession>>> getCustomerSessions(
    String customerId,
  );

  Future<ApiResponse<void>> terminateSession({required String sessionId});
}
