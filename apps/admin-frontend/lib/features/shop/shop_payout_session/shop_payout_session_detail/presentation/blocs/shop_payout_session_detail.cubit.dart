import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/enums/payout_method_type.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/graphql/shop_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/data/repositories/shop_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_payout_session_detail.state.dart';
part 'shop_payout_session_detail.cubit.freezed.dart';

class ShopPayoutSessionDetailBloc extends Cubit<ShopPayoutSessionDetailState> {
  final ShopPayoutSessionDetailRepository _payoutSessionDetailRepository =
      locator<ShopPayoutSessionDetailRepository>();

  ShopPayoutSessionDetailBloc() : super(ShopPayoutSessionDetailState());

  void onStarted({required String id}) {
    emit(state.copyWith(payoutSessionId: id));
    _fetchPayoutSession();
  }

  void _fetchPayoutSession() async {
    final payoutSessionDetailOrError = await _payoutSessionDetailRepository
        .getPayoutSessionDetail(id: state.payoutSessionId!);
    final payoutSessionDetailState = payoutSessionDetailOrError;
    emit(state.copyWith(payoutSessionDetailState: payoutSessionDetailState));
    final firstPayoutMethodOrNull =
        payoutSessionDetailState.data?.payoutMethodDetails.firstOrNull;
    if (firstPayoutMethodOrNull != null) {
      onPayoutMethodSelected(firstPayoutMethodOrNull.id);
    }
  }

  void onChangePayoutSessionStatus(Enum$PayoutSessionStatus? status) async {
    if (status == null) return;
    final updatedPayoutSessionOrError = await _payoutSessionDetailRepository
        .updatePayoutSessionStatus(id: state.payoutSessionId!, status: status);
    emit(state.copyWith(payoutSessionDetailState: updatedPayoutSessionOrError));
  }

  void onPayoutMethodSelected(String payoutSessionPayoutMethodId) {
    emit(state.copyWith(selectedPayoutMethodId: payoutSessionPayoutMethodId));
    _fetchShopTransactions();
  }

  void _fetchShopTransactions() async {
    final shopTransactionsOrError = await _payoutSessionDetailRepository
        .getShopTransactions(
          payoutSessionPayoutMethodId: state.selectedPayoutMethodId!,
          paging: state.transactionsPaging,
        );
    emit(state.copyWith(shopTransactionsState: shopTransactionsOrError));
  }

  void runAutoPayout() async {
    await _payoutSessionDetailRepository.runAutoPayout(
      payoutSessionId: state.payoutSessionId!,
      payoutMethodId: state.selectedPayoutMethodId!,
    );
    _fetchShopTransactions();
  }

  Future<ApiResponse<String>> exportPayoutToCSV() {
    return _payoutSessionDetailRepository.exportPayoutToCSV(
      payoutSessionId: state.payoutSessionId!,
      payoutMethodId: state.selectedPayoutMethodId!,
    );
  }

  void onShopTransactionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchShopTransactions();
  }
}
