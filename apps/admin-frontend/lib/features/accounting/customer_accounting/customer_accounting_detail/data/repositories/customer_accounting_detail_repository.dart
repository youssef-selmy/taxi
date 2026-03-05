import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/graphql/customer_accounting_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerAccountingDetailRepository {
  Future<ApiResponse<Query$customerWalletDetailSummary>>
  getWalletDetailSummary({required String riderId});

  Future<ApiResponse<Query$customerTransactions>> getCustomerTransactions({
    required String currency,
    required List<Enum$TransactionAction> actionFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String riderId,
    required List<Input$RiderTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
