import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/graphql/admin_accounting_dashboard.graphql.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/repositories/admin_accounting_dashboard_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: AdminAccountingDashboardRepository)
class AdminAccountingDashboardRepositoryMock
    implements AdminAccountingDashboardRepository {
  @override
  Future<ApiResponse<Query$adminWalletSummary>> getAdminWalletSummary({
    required String currency,
    required Input$ChartFilterInput chartFilterInput,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$adminWalletSummary(
        adminWallets: [
          mockAdminWalletUSD,
          mockAdminWalletEUR,
          mockAdminWalletGBP,
        ],
        totalRevenue: Fragment$totalDailyPair(daily: 42000, total: 96432100),
        totaloutstandingUserBalances: Fragment$totalDailyPair(
          daily: 5154,
          total: 6931000,
        ),
        totalExpenses: Fragment$totalDailyPair(daily: 6330, total: 54333000),
        providerWalletBalanceHistory: mockFinancialTimelines,
        providerExpenseBreakdownHistory: [
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.CloudServices,
            dateString: "Jan",
            anyDate: DateTime(2025, 1),
            value: 100,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.Marketing,
            dateString: "Jan",
            anyDate: DateTime(2025, 1),
            value: 60,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.TechnologyDevelopment,
            dateString: "Jan",
            anyDate: DateTime(2025, 1),
            value: 40,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.TechnologyDevelopment,
            dateString: "Feb",
            anyDate: DateTime(2025, 2),
            value: 80,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.CloudServices,
            dateString: "Feb",
            anyDate: DateTime(2025, 2),
            value: 40,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.Marketing,
            dateString: "Mar",
            anyDate: DateTime(2025, 3),
            value: 100,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.CloudServices,
            dateString: "Mar",
            anyDate: DateTime(2025, 3),
            value: 60,
          ),
          Query$adminWalletSummary$providerExpenseBreakdownHistory(
            expenseType: Enum$ProviderExpenseType.TechnologyDevelopment,
            dateString: "Apr",
            anyDate: DateTime(2025, 4),
            value: 40,
          ),
        ],
        providerRevenueExpenseHistory: [
          Query$adminWalletSummary$providerRevenueExpenseHistory(
            anyDate: DateTime(2025, 1),
            dateString: "Jan",
            revenue: 100,
            expense: 21,
          ),
          Query$adminWalletSummary$providerRevenueExpenseHistory(
            anyDate: DateTime(2025, 2),
            dateString: "Feb",
            revenue: 200,
            expense: 42,
          ),
          Query$adminWalletSummary$providerRevenueExpenseHistory(
            anyDate: DateTime(2025, 3),
            dateString: "Mar",
            revenue: 160,
            expense: 33,
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<Query$adminTransactions>> getAdminTransactions({
    required Input$OffsetPaging? paging,
    required Input$ProviderTransactionFilter filter,
    required List<Input$ProviderTransactionSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$adminTransactions(
        adminTransactions: Query$adminTransactions$adminTransactions(
          pageInfo: mockPageInfo,
          totalCount: mockAdminTransactions.length,
          nodes: mockAdminTransactions,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<String>> exportAdminTransactions({
    required List<Input$ProviderTransactionSort> sort,
    required Input$ProviderTransactionFilter filter,
    required Enum$ExportFormat format,
  }) async {
    return ApiResponse.loaded("http://example.com/exported_transactions.csv");
  }
}
