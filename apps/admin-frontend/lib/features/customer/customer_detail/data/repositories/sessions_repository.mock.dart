import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_session.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_session.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/sessions_repository.dart';

@dev
@LazySingleton(as: SessionsRepository)
class SessionsRepositoryMock implements SessionsRepository {
  @override
  Future<ApiResponse<List<Fragment$customerSession>>> getCustomerSessions(
    String customerId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockCustomerSessions);
  }

  @override
  Future<ApiResponse<void>> terminateSession({
    required String sessionId,
  }) async {
    return ApiResponse.loaded(null);
  }
}
