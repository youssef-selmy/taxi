import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_list/data/graphql/parking_payout_session_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingPayoutSessionListRepository {
  Future<ApiResponse<Query$parkingsPendingPayoutSessions>>
  getParkingsPendingPayoutSessions();

  Future<ApiResponse<Query$parkingsPayoutSessions>> getParkingsPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$ParkingPayoutSessionSort> sorting,
    required Input$ParkingPayoutSessionFilter filter,
  });

  Future<ApiResponse<Query$parkingsPayoutTransactions>>
  getParkingsPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$ParkingTransactionSort> sorting,
    required Input$ParkingTransactionFilter filter,
  });
}
