import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/data/graphql/driver_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/data/repositories/driver_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverPayoutSessionListRepository)
class DriverPayoutSessionListRepositoryMock
    implements DriverPayoutSessionListRepository {
  @override
  Future<ApiResponse<Query$driversPayoutTransactions>>
  getDriversPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$DriverTransactionSort> sorting,
    required Input$DriverTransactionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driversPayoutTransactions(
        payoutTransactions: Query$driversPayoutTransactions$payoutTransactions(
          nodes: [
            Query$driversPayoutTransactions$payoutTransactions$nodes(
              id: "1",
              action: Enum$TransactionAction.Recharge,
              status: Enum$TransactionStatus.Done,
              amount: 100,
              currency: "USD",
              createdAt: DateTime.now().subtract(const Duration(hours: 10)),
              driver: mockDriverName1,
            ),
            Query$driversPayoutTransactions$payoutTransactions$nodes(
              id: "1",
              action: Enum$TransactionAction.Recharge,
              status: Enum$TransactionStatus.Done,
              amount: 120,
              currency: "USD",
              createdAt: DateTime.now().subtract(const Duration(hours: 3)),
              driver: mockDriverName2,
            ),
          ],
          totalCount: mockDriverTransactionList.length,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$driversPayoutSessions>> getDriversPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$TaxiPayoutSessionSort> sorting,
    required Input$TaxiPayoutSessionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driversPayoutSessions(
        taxiPayoutSessions: Query$driversPayoutSessions$taxiPayoutSessions(
          nodes: mockTaxiPayoutSessionListItems,
          totalCount: mockTaxiPayoutSessionListItems.length,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$driversPendingPayoutSessions>>
  getDriversPendingPayoutSessions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driversPendingPayoutSessions(
        pendingSessions: Query$driversPendingPayoutSessions$pendingSessions(
          nodes: mockTaxiPayoutSessionListItems,
          totalCount: mockTaxiPayoutSessionListItems.length,
        ),
      ),
    );
  }
}
