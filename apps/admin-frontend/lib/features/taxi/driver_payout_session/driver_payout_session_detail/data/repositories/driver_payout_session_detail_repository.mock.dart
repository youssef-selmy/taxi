import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/graphql/driver_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/repositories/driver_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverPayoutSessionDetailRepository)
class DriverPayoutSessionDetailRepositoryMock
    implements DriverPayoutSessionDetailRepository {
  @override
  Future<ApiResponse<Fragment$taxiPayoutSessionDetail>> getPayoutSessionDetail({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockPayoutPayoutSessionDetail);
  }

  @override
  Future<ApiResponse<Fragment$taxiPayoutSessionDetail>>
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
  Future<ApiResponse<Query$payoutSessionPayoutMethodDriverTransactions>>
  getDriverTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  }) async {
    return ApiResponse.loaded(
      Query$payoutSessionPayoutMethodDriverTransactions(
        driverTransactions:
            Query$payoutSessionPayoutMethodDriverTransactions$driverTransactions(
              pageInfo: mockPageInfo,
              totalCount: mockDriverTransactionPayouts.length,
              nodes: mockDriverTransactionPayouts,
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
