import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/graphql/admin_accounting_dashboard.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class AdminAccountingDashboardRepository {
  Future<ApiResponse<Query$adminWalletSummary>> getAdminWalletSummary({
    required String currency,
    required Input$ChartFilterInput chartFilterInput,
  });

  Future<ApiResponse<Query$adminTransactions>> getAdminTransactions({
    required Input$OffsetPaging? paging,
    required Input$ProviderTransactionFilter filter,
    required List<Input$ProviderTransactionSort> sort,
  });

  Future<ApiResponse<String>> exportAdminTransactions({
    required List<Input$ProviderTransactionSort> sort,
    required Input$ProviderTransactionFilter filter,
    required Enum$ExportFormat format,
  });
}
