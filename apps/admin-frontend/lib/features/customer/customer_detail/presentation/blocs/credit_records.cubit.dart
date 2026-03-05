import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/credit_records.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'credit_records.state.dart';
part 'credit_records.cubit.freezed.dart';

class CreditRecordsBloc extends Cubit<CreditRecordsState> {
  final CreditRecordsRepository _creditRecordsRepository =
      locator<CreditRecordsRepository>();

  CreditRecordsBloc() : super(CreditRecordsState());

  void onStarted({required String customerId}) {
    emit(state.copyWith(customerId: customerId));
    _fetchCreditRecords();
    _fetchWalletBalance();
  }

  void refresh() {
    _fetchCreditRecords();
    _fetchWalletBalance();
  }

  void _fetchWalletBalance() async {
    emit(state.copyWith(walletState: const ApiResponse.loading()));
    final walletBalance = await _creditRecordsRepository.getWalletBalance(
      customerId: state.customerId!,
    );
    emit(state.copyWith(walletState: walletBalance));
  }

  void _fetchCreditRecords() async {
    emit(state.copyWith(creditRecordsState: const ApiResponse.loading()));
    final creditRecords = await _creditRecordsRepository.getCreditRecords(
      customerId: state.customerId!,
      paging: state.paging,
      status: state.transactionStatusFilters,
      action: state.transactionActionFilters,
      sort: state.transactionSorts,
    );
    emit(state.copyWith(creditRecordsState: creditRecords));
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(transactionStatusFilters: selectedItems));
    _fetchCreditRecords();
  }

  void onTransactionSortChanged(
    List<Input$RiderTransactionSort> selectedItems,
  ) {
    emit(state.copyWith(transactionSorts: selectedItems));
    _fetchCreditRecords();
  }

  void onTransactionActionFilterChanged(
    List<Enum$TransactionAction> selectedItems,
  ) {
    emit(state.copyWith(transactionActionFilters: selectedItems));
    _fetchCreditRecords();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchCreditRecords();
  }

  void export(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _creditRecordsRepository.exportCreditRecords(
      filter: Input$RiderTransactionFilter(
        riderId: Input$IDFilterComparison(eq: state.customerId!),
        status: state.transactionStatusFilters.isEmpty
            ? null
            : Input$TransactionStatusFilterComparison(
                $in: state.transactionStatusFilters,
              ),
        action: state.transactionActionFilters.isEmpty
            ? null
            : Input$TransactionActionFilterComparison(
                $in: state.transactionActionFilters,
              ),
      ),
      sort: state.transactionSorts,
      format: format,
    );
    emit(state.copyWith(exportState: exportOrError));
  }
}
