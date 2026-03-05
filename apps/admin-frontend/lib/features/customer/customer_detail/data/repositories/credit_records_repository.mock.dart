import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/credit_records.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CreditRecordsRepository)
class CreditRecordsRepositoryMock implements CreditRecordsRepository {
  @override
  Future<ApiResponse<Query$customerCreditRecords>> getCreditRecords({
    required String customerId,
    required Input$OffsetPaging? paging,
    required List<Enum$TransactionStatus>? status,
    required List<Enum$TransactionAction>? action,
    required List<Input$RiderTransactionSort>? sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return ApiResponse.loaded(
      Query$customerCreditRecords(
        riderTransactions: Query$customerCreditRecords$riderTransactions(
          nodes: mockCustomerTransactions,
          totalCount: mockCustomerTransactions.length,
          pageInfo: Fragment$OffsetPageInfo(
            hasNextPage: false,
            hasPreviousPage: false,
          ),
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String customerId,
  }) async {
    return ApiResponse.loaded(mockCustomerWallets.toWalletBalanceItems());
  }

  @override
  Future<ApiResponse<String>> exportCreditRecords({
    required List<Input$RiderTransactionSort> sort,
    required Input$RiderTransactionFilter filter,
    required Enum$ExportFormat format,
  }) async {
    return ApiResponse.loaded(
      "https://example.com/exported_credit_records.${format.name.toLowerCase()}",
    );
  }
}
