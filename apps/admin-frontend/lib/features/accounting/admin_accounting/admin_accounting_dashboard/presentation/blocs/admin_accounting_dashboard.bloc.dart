import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/graphql/admin_accounting_dashboard.graphql.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/repositories/admin_accounting_dashboard_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'admin_accounting_dashboard.state.dart';
part 'admin_accounting_dashboard.bloc.freezed.dart';

class AdminAccountingDashboardBloc
    extends Cubit<AdminAccountingDashboardState> {
  final AdminAccountingDashboardRepository _adminAccountingDashboardRepository =
      locator<AdminAccountingDashboardRepository>();

  AdminAccountingDashboardBloc()
    : super(AdminAccountingDashboardState.initial());

  void onStarted() {
    _fetchAdminWalletSummary();
    _fetchAdminTransactions();
  }

  void changeCurrency(String currency) {
    emit(state.copyWith(currency: currency));
    _fetchAdminWalletSummary();
    _fetchAdminTransactions();
  }

  void _fetchAdminWalletSummary() async {
    emit(state.copyWith(summaryState: const ApiResponse.loading()));
    final adminWalletSummaryOrError = await _adminAccountingDashboardRepository
        .getAdminWalletSummary(
          currency: state.currency,
          chartFilterInput: state.chartFilterInput,
        );
    final adminWalletSummaryState = adminWalletSummaryOrError;
    emit(state.copyWith(summaryState: adminWalletSummaryState));
  }

  void _fetchAdminTransactions() async {
    emit(state.copyWith(transactionsState: const ApiResponse.loading()));
    final adminTransactionsOrError = await _adminAccountingDashboardRepository
        .getAdminTransactions(
          paging: state.transactionsPaging,
          filter: Input$ProviderTransactionFilter(
            currency: Input$StringFieldComparison(eq: state.currency),
          ),
          sort: state.sort,
        );
    final transactionsState = adminTransactionsOrError;
    emit(state.copyWith(transactionsState: transactionsState));
  }

  void changeChartFilterInput(Input$ChartFilterInput p0) {
    emit(state.copyWith(chartFilterInput: p0));
    _fetchAdminWalletSummary();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchAdminTransactions();
  }

  void onExport(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _adminAccountingDashboardRepository
        .exportAdminTransactions(
          sort: state.sort,
          filter: Input$ProviderTransactionFilter(
            currency: Input$StringFieldComparison(eq: state.currency),
          ),
          format: format,
        );
    final exportState = exportOrError;
    emit(state.copyWith(exportState: exportState));
  }
}
