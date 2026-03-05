import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/graphql/driver_payout_session_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverPayoutSessionDetailRepository {
  Future<ApiResponse<Fragment$taxiPayoutSessionDetail>> getPayoutSessionDetail({
    required String id,
  });

  Future<ApiResponse<Fragment$taxiPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  });

  Future<ApiResponse<Query$payoutSessionPayoutMethodDriverTransactions>>
  getDriverTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  });

  Future<ApiResponse<void>> runAutoPayout({
    required String payoutSessionId,
    required String payoutMethodId,
  });

  Future<ApiResponse<String>> exportPayoutToCSV({
    required String payoutSessionId,
    required String payoutMethodId,
  });
}
