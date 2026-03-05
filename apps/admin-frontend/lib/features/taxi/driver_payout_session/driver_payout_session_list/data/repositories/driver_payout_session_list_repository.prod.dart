import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/data/graphql/driver_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/data/repositories/driver_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverPayoutSessionListRepository)
class DriverPayoutSessionListRepositoryImpl
    implements DriverPayoutSessionListRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverPayoutSessionListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driversPayoutTransactions>>
  getDriversPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$DriverTransactionSort> sorting,
    required Input$DriverTransactionFilter filter,
  }) async {
    final transactionsOrError = await graphQLDatasource.query(
      Options$Query$driversPayoutTransactions(
        variables: Variables$Query$driversPayoutTransactions(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return transactionsOrError;
  }

  @override
  Future<ApiResponse<Query$driversPayoutSessions>> getDriversPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$TaxiPayoutSessionSort> sorting,
    required Input$TaxiPayoutSessionFilter filter,
  }) async {
    final sessionsOrError = await graphQLDatasource.query(
      Options$Query$driversPayoutSessions(
        variables: Variables$Query$driversPayoutSessions(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return sessionsOrError;
  }

  @override
  Future<ApiResponse<Query$driversPendingPayoutSessions>>
  getDriversPendingPayoutSessions() async {
    final pendingSessionsOrError = await graphQLDatasource.query(
      Options$Query$driversPendingPayoutSessions(),
    );
    return pendingSessionsOrError;
  }
}
