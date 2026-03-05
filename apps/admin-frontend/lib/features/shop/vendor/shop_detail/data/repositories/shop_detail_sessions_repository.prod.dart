import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_sessions.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_sessions_repository.dart';

@prod
@LazySingleton(as: ShopDetailSessionsRepository)
class ShopDetailSessionsRepositoryImpl implements ShopDetailSessionsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailSessionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopLoginSessions>> getSessions({
    required String ownerId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$shopLoginSessions(
        variables: Variables$Query$shopLoginSessions(customerId: ownerId),
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
