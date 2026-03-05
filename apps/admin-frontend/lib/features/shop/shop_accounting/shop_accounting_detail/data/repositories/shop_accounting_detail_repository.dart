import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/graphql/shop_accounting_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopAccountingDetailRepository {
  Future<ApiResponse<Query$shopWalletDetailSummary>> getWalletDetailSummary({
    required String shopId,
  });

  Future<ApiResponse<Query$shopTransactions>> getShopTransactions({
    required String currency,
    required List<Enum$TransactionType> typeFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String shopId,
    required List<Input$ShopTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
