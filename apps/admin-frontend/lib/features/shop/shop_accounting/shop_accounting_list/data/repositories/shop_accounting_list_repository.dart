import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/graphql/shop_accounting_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopAccountingListRepository {
  Future<ApiResponse<Query$shopWalletsSummary>> getWalletsSummary({
    required String? currency,
  });

  Future<ApiResponse<Query$shopWallets>> getWalletList({
    required String? currency,
    required List<Input$ShopWalletSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
