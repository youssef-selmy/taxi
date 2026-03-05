import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_credit_records.state.dart';
part 'shop_detail_credit_records.bloc.freezed.dart';

class ShopDetailCreditRecordsBloc extends Cubit<ShopDetailCreditRecordsState> {
  final ShopDetailCreditRecordsRepository _shopDetailCreditRecordsRepository =
      locator<ShopDetailCreditRecordsRepository>();

  ShopDetailCreditRecordsBloc() : super(ShopDetailCreditRecordsState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    refresh();
  }

  void refresh() {
    _fetchCreditRecords();
    _fetchWalletBalance();
  }

  void _fetchWalletBalance() async {
    emit(state.copyWith(walletState: const ApiResponse.loading()));
    final walletBalanceOrError = await _shopDetailCreditRecordsRepository
        .getWalletBalance(ownerId: state.shopId!);
    final walletBalanceState = walletBalanceOrError;
    emit(state.copyWith(walletState: walletBalanceState));
  }

  void _fetchCreditRecords() async {
    emit(state.copyWith(creditRecordsState: const ApiResponse.loading()));
    final creditRecords = await _shopDetailCreditRecordsRepository
        .getCreditRecords(
          paging: state.paging,
          sorting: state.sorting,
          filter: state.filter,
        );
    emit(state.copyWith(creditRecordsState: creditRecords));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchCreditRecords();
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(statusFilters: selectedItems));
    _fetchCreditRecords();
  }

  void onTransactionSortChanged(List<Input$ShopTransactionSort> selectedItems) {
    emit(state.copyWith(sorting: selectedItems));
    _fetchCreditRecords();
  }

  void onTransactionActionFilterChanged(
    List<Enum$TransactionType> selectedItems,
  ) {
    emit(state.copyWith(typeFilters: selectedItems));
    _fetchCreditRecords();
  }

  void export(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _shopDetailCreditRecordsRepository.export(
      filter: state.filter,
      sorting: state.sorting,
      format: format,
    );
    emit(state.copyWith(exportState: exportOrError));
  }
}
