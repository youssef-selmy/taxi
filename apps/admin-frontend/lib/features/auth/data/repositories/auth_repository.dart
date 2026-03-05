import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/auth/data/graphql/auth.graphql.dart';

abstract class AuthRepository {
  Future<ApiResponse<Mutation$DisableServer>> disableServer({
    required String purchaseCode,
    required String ip,
  });
}
