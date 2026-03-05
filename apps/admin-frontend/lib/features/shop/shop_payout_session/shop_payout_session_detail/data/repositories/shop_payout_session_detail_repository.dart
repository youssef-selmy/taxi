import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/graphql/shop_payout_session_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopPayoutSessionDetailRepository {
  Future<ApiResponse<Fragment$shopPayoutSessionDetail>> getPayoutSessionDetail({
    required String id,
  });

  Future<ApiResponse<Fragment$shopPayoutSessionDetail>>
  updatePayoutSessionStatus({
    required String id,
    required Enum$PayoutSessionStatus status,
  });

  Future<ApiResponse<Query$shopPayoutSessionPayoutMethodShopTransactions>>
  getShopTransactions({
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
