import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/data/graphql/driver_payout_session_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverPayoutSessionListRepository {
  Future<ApiResponse<Query$driversPendingPayoutSessions>>
  getDriversPendingPayoutSessions();

  Future<ApiResponse<Query$driversPayoutSessions>> getDriversPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$TaxiPayoutSessionSort> sorting,
    required Input$TaxiPayoutSessionFilter filter,
  });

  Future<ApiResponse<Query$driversPayoutTransactions>>
  getDriversPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$DriverTransactionSort> sorting,
    required Input$DriverTransactionFilter filter,
  });
}
