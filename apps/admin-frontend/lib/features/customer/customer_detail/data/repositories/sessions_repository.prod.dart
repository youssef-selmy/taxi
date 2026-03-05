import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_session.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/sessions.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/sessions_repository.dart';

@prod
@LazySingleton(as: SessionsRepository)
class SessionsRepositoryImpl implements SessionsRepository {
  final GraphqlDatasource graphQLDatasource;

  SessionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$customerSession>>> getCustomerSessions(
    String customerId,
  ) async {
    final sessions = await graphQLDatasource.query(
      Options$Query$customerSessions(
        variables: Variables$Query$customerSessions(customerId: customerId),
      ),
    );
    return sessions.mapData((r) => r.customerSessions);
  }

  @override
  Future<ApiResponse<void>> terminateSession({
    required String sessionId,
  }) async {
    final deleteResultOrError = await graphQLDatasource.mutate(
      Options$Mutation$terminateCustomerLoginSession(
        variables: Variables$Mutation$terminateCustomerLoginSession(
          sessionId: sessionId,
        ),
      ),
    );
    return deleteResultOrError;
  }
}
