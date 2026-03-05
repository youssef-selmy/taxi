import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_credit_records.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailCreditRecordsRepository {
  Future<ApiResponse<Query$shopCreditRecords>> getCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$ShopTransactionFilter filter,
    required List<Input$ShopTransactionSort> sorting,
  });

  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String ownerId,
  });

  Future<ApiResponse<String>> export({
    required Input$ShopTransactionFilter filter,
    required List<Input$ShopTransactionSort> sorting,
    required Enum$ExportFormat format,
  });
}
