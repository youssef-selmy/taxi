import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/graphql/shop_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/repositories/shop_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopPayoutSessionDetailRepository)
class ShopPayoutSessionDetailRepositoryMock
    implements ShopPayoutSessionDetailRepository {
  @override
  Future<ApiResponse<Fragment$shopPayoutSessionDetail>> getPayoutSessionDetail({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockPayoutPayoutSessionDetail);
  }

  @override
  Future<ApiResponse<Fragment$shopPayoutSessionDetail>>
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
  Future<ApiResponse<Query$shopPayoutSessionPayoutMethodShopTransactions>>
  getShopTransactions({
    required String payoutSessionPayoutMethodId,
    required Input$OffsetPaging? paging,
  }) async {
    return ApiResponse.loaded(
      Query$shopPayoutSessionPayoutMethodShopTransactions(
        shopTransactions:
            Query$shopPayoutSessionPayoutMethodShopTransactions$shopTransactions(
              pageInfo: mockPageInfo,
              totalCount: mockShopTransactionPayouts.length,
              nodes: mockShopTransactionPayouts,
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
