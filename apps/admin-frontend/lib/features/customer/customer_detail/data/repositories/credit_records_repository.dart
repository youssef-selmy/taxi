import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/credit_records.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CreditRecordsRepository {
  Future<ApiResponse<Query$customerCreditRecords>> getCreditRecords({
    required String customerId,
    required Input$OffsetPaging? paging,
    required List<Enum$TransactionStatus>? status,
    required List<Enum$TransactionAction>? action,
    required List<Input$RiderTransactionSort>? sort,
  });

  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String customerId,
  });

  Future<ApiResponse<String>> exportCreditRecords({
    required List<Input$RiderTransactionSort> sort,
    required Input$RiderTransactionFilter filter,
    required Enum$ExportFormat format,
  });
}
