import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/enums/payout_method_type.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/graphql/driver_payout_session_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/data/repositories/driver_payout_session_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_payout_session_detail.state.dart';
part 'driver_payout_session_detail.cubit.freezed.dart';

class DriverPayoutSessionDetailBloc
    extends Cubit<DriverPayoutSessionDetailState> {
  final DriverPayoutSessionDetailRepository _payoutSessionDetailRepository =
      locator<DriverPayoutSessionDetailRepository>();

  DriverPayoutSessionDetailBloc() : super(DriverPayoutSessionDetailState());

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
    _fetchDriverTransactions();
  }

  void _fetchDriverTransactions() async {
    final driverTransactionsOrError = await _payoutSessionDetailRepository
        .getDriverTransactions(
          payoutSessionPayoutMethodId: state.selectedPayoutMethodId!,
          paging: state.transactionsPaging,
        );
    emit(state.copyWith(driverTransactionsState: driverTransactionsOrError));
  }

  void runAutoPayout() async {
    await _payoutSessionDetailRepository.runAutoPayout(
      payoutSessionId: state.payoutSessionId!,
      payoutMethodId: state.selectedPayoutMethodId!,
    );
    _fetchDriverTransactions();
  }

  Future<ApiResponse<String>> exportPayoutToCSV() {
    return _payoutSessionDetailRepository.exportPayoutToCSV(
      payoutSessionId: state.payoutSessionId!,
      payoutMethodId: state.selectedPayoutMethodId!,
    );
  }

  void onTransactionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchDriverTransactions();
  }
}
