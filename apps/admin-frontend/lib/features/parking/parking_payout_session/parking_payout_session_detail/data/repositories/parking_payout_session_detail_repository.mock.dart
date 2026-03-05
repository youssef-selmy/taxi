import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/data/graphql/parking_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/data/repositories/parking_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingPayoutSessionDetailRepository)
class ParkingPayoutSessionDetailRepositoryMock
    implements ParkingPayoutSessionDetailRepository {
  @override
  Future<ApiResponse<Fragment$parkingPayoutSessionDetail>>
  getPayoutSessionDetail({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockPayoutPayoutSessionDetail);
  }

  @override
  Future<ApiResponse<Fragment$parkingPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      mockPayoutPayoutSessionDetail.copyWith(status: status),
    );
  }

  @override
  Future<ApiResponse<Query$parkingPayoutSessionPayoutMethodParkingTransactions>>
  getParkingTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  }) async {
    return ApiResponse.loaded(
      Query$parkingPayoutSessionPayoutMethodParkingTransactions(
        parkingTransactions:
            Query$parkingPayoutSessionPayoutMethodParkingTransactions$parkingTransactions(
              pageInfo: mockPageInfo,
              totalCount: mockParkingTransactionPayouts.length,
              nodes: mockParkingTransactionPayouts,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<String>> exportPayoutToCSV({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    return const ApiResponse.loaded("https://www.google.com");
  }

  @override
  Future<ApiResponse<void>> runAutoPayout({
    required String payoutSessionId,
    required String payoutMethodId,
  }) async {
    return const ApiResponse.loaded(null);
  }
}
