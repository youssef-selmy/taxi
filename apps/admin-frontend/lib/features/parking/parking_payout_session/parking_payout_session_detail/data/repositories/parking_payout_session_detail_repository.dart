import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/data/graphql/parking_payout_session_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingPayoutSessionDetailRepository {
  Future<ApiResponse<Fragment$parkingPayoutSessionDetail>>
  getPayoutSessionDetail({required String id});

  Future<ApiResponse<Fragment$parkingPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  });

  Future<ApiResponse<Query$parkingPayoutSessionPayoutMethodParkingTransactions>>
  getParkingTransactions({
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
