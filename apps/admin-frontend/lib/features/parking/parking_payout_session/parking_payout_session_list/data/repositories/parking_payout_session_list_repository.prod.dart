import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_list/data/graphql/parking_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_list/data/repositories/parking_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingPayoutSessionListRepository)
class ParkingPayoutSessionListRepositoryImpl
    implements ParkingPayoutSessionListRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingPayoutSessionListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingsPayoutTransactions>>
  getParkingsPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$ParkingTransactionSort> sorting,
    required Input$ParkingTransactionFilter filter,
  }) async {
    final transactionsOrError = await graphQLDatasource.query(
      Options$Query$parkingsPayoutTransactions(
        variables: Variables$Query$parkingsPayoutTransactions(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return transactionsOrError;
  }

  @override
  Future<ApiResponse<Query$parkingsPayoutSessions>> getParkingsPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$ParkingPayoutSessionSort> sorting,
    required Input$ParkingPayoutSessionFilter filter,
  }) async {
    final sessionsOrError = await graphQLDatasource.query(
      Options$Query$parkingsPayoutSessions(
        variables: Variables$Query$parkingsPayoutSessions(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return sessionsOrError;
  }

  @override
  Future<ApiResponse<Query$parkingsPendingPayoutSessions>>
  getParkingsPendingPayoutSessions() async {
    final pendingSessionsOrError = await graphQLDatasource.query(
      Options$Query$parkingsPendingPayoutSessions(),
    );
    return pendingSessionsOrError;
  }
}
