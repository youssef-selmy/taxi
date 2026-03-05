import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_list/data/graphql/parking_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_list/data/repositories/parking_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingPayoutSessionListRepository)
class ParkingPayoutSessionListRepositoryMock
    implements ParkingPayoutSessionListRepository {
  @override
  Future<ApiResponse<Query$parkingsPayoutTransactions>>
  getParkingsPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$ParkingTransactionSort> sorting,
    required Input$ParkingTransactionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingsPayoutTransactions(
        payoutTransactions: Query$parkingsPayoutTransactions$payoutTransactions(
          nodes: [
            Query$parkingsPayoutTransactions$payoutTransactions$nodes(
              id: "1",
              transactionDate: DateTime.now().subtract(
                const Duration(hours: 10),
              ),
              type: Enum$TransactionType.Credit,
              status: Enum$TransactionStatus.Done,
              amount: 100,
              currency: "USD",
              createdAt: DateTime.now().subtract(const Duration(hours: 10)),
              customer: mockCustomerCompact1,
            ),
            Query$parkingsPayoutTransactions$payoutTransactions$nodes(
              id: "2",
              transactionDate: DateTime.now().subtract(
                const Duration(hours: 10),
              ),
              type: Enum$TransactionType.Credit,
              status: Enum$TransactionStatus.Done,
              amount: 120,
              currency: "USD",
              createdAt: DateTime.now().subtract(const Duration(hours: 3)),
              customer: mockCustomerCompact5,
            ),
          ],
          totalCount: 2,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkingsPayoutSessions>> getParkingsPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$ParkingPayoutSessionSort> sorting,
    required Input$ParkingPayoutSessionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingsPayoutSessions(
        parkingPayoutSessions:
            Query$parkingsPayoutSessions$parkingPayoutSessions(
              nodes: mockParkingPayoutSessionListItems,
              totalCount: mockParkingPayoutSessionListItems.length,
              pageInfo: mockPageInfo,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkingsPendingPayoutSessions>>
  getParkingsPendingPayoutSessions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingsPendingPayoutSessions(
        pendingSessions: Query$parkingsPendingPayoutSessions$pendingSessions(
          nodes: mockParkingPayoutSessionListItems,
          totalCount: mockParkingPayoutSessionListItems.length,
        ),
      ),
    );
  }
}
