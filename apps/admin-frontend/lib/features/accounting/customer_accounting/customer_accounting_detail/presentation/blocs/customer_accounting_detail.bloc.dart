import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/graphql/customer_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/data/repositories/customer_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customer_accounting_detail.state.dart';
part 'customer_accounting_detail.bloc.freezed.dart';

class CustomerAccountingDetailBloc
    extends Cubit<CustomerAccountingDetailState> {
  final CustomerAccountingDetailRepository _customerAccountingDetailRepository =
      locator<CustomerAccountingDetailRepository>();

  CustomerAccountingDetailBloc() : super(CustomerAccountingDetailState());

  void onStarted({required String currency, required String customerId}) {
    emit(
      CustomerAccountingDetailState(currency: currency, customerId: customerId),
    );
    _fetchWalletDetailSummary();
    _fetchCustomerTransactions();
  }

  void _fetchWalletDetailSummary() async {
    emit(state.copyWith(walletSummaryState: const ApiResponse.loading()));
    final walletDetailSummaryOrError = await _customerAccountingDetailRepository
        .getWalletDetailSummary(riderId: state.customerId!);
    final walletDetailSummaryState = walletDetailSummaryOrError;
    emit(state.copyWith(walletSummaryState: walletDetailSummaryState));
  }

  void _fetchCustomerTransactions() async {
    emit(state.copyWith(transactionListState: const ApiResponse.loading()));
    final customerTransactionsOrError =
        await _customerAccountingDetailRepository.getCustomerTransactions(
          currency: state.currency!,
          riderId: state.customerId!,
          sorting: state.transactionSortings,
          statusFilter: state.transactionStatusFilter,
          actionFilter: state.transactionActionFilter,
          paging: state.transactionsPaging,
        );
    final customerTransactionsState = customerTransactionsOrError;
    emit(state.copyWith(transactionListState: customerTransactionsState));
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(transactionStatusFilter: selectedItems));
    _fetchCustomerTransactions();
  }

  void onTransactionActionFilterChanged(
    List<Enum$TransactionAction> selectedItems,
  ) {
    emit(state.copyWith(transactionActionFilter: selectedItems));
    _fetchCustomerTransactions();
  }

  void onTransactionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchCustomerTransactions();
  }
}
