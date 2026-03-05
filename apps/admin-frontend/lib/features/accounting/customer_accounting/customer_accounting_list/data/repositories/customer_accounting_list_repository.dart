import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/data/graphql/customer_accounting_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerAccountingListRepository {
  Future<ApiResponse<Query$customerWalletsSummary>> getWalletsSummary({
    required String currency,
  });

  Future<ApiResponse<Query$customerWallets>> getWalletList({
    required String currency,
    required List<Input$RiderWalletSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
