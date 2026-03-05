import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/graphql/admin_accounting_dashboard.graphql.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/repositories/admin_accounting_dashboard_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: AdminAccountingDashboardRepository)
class AdminAccountingDashboardRepositoryImpl
    implements AdminAccountingDashboardRepository {
  final GraphqlDatasource graphQLDatasource;

  AdminAccountingDashboardRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$adminWalletSummary>> getAdminWalletSummary({
    required String currency,
    required Input$ChartFilterInput chartFilterInput,
  }) async {
    final walletSummaryOrError = await graphQLDatasource.query(
      Options$Query$adminWalletSummary(
        variables: Variables$Query$adminWalletSummary(
          currency: currency,
          chartFilterInput: chartFilterInput,
        ),
      ),
    );
    return walletSummaryOrError;
  }

  @override
  Future<ApiResponse<Query$adminTransactions>> getAdminTransactions({
    required Input$OffsetPaging? paging,
    required Input$ProviderTransactionFilter filter,
    required List<Input$ProviderTransactionSort> sort,
  }) async {
    final transactionsOrError = await graphQLDatasource.query(
      Options$Query$adminTransactions(
        variables: Variables$Query$adminTransactions(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return transactionsOrError;
  }

  @override
  Future<ApiResponse<String>> exportAdminTransactions({
    required List<Input$ProviderTransactionSort> sort,
    required Input$ProviderTransactionFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final exportOrError = await graphQLDatasource.query(
      Options$Query$exportAdminTransactions(
        variables: Variables$Query$exportAdminTransactions(
          sorting: sort,
          filter: filter,
          format: format,
        ),
      ),
    );
    return exportOrError.mapData((data) => data.exportProviderTransactions);
  }
}
