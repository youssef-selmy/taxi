import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/new_batch_payout_session_dialog/data/graphql/new_batch_payout_session_dialog.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/new_batch_payout_session_dialog/data/repositories/new_batch_payout_session_dialog_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'new_batch_payout_session_dialog.state.dart';
part 'new_batch_payout_session_dialog.cubit.freezed.dart';

class NewBatchPayoutSessionDialogBloc
    extends Cubit<NewBatchPayoutSessionDialogState> {
  final NewBatchPayoutSessionDialogRepository
  _newBatchPayoutSessionDialogRepository =
      locator<NewBatchPayoutSessionDialogRepository>();

  NewBatchPayoutSessionDialogBloc()
    : super(NewBatchPayoutSessionDialogState.initial());

  void onStarted({required Enum$AppType appType}) {
    emit(state.copyWith(appType: appType));
    _fetchPayoutMethods();
  }

  Future<void> _fetchPayoutMethods() async {
    emit(state.copyWith(payoutMethodsState: const ApiResponse.loading()));
    final payoutMethodsOrError = await _newBatchPayoutSessionDialogRepository
        .getPayoutMethods();
    final payoutMethodsState = payoutMethodsOrError;
    emit(state.copyWith(payoutMethodsState: payoutMethodsState));
  }

  void onPayoutMethodsChanged(List<String>? payoutMethods) =>
      emit(state.copyWith(selectedPayoutMethodIds: payoutMethods ?? []));

  void onCurrencyChanged(String? currency) =>
      emit(state.copyWith(currency: currency!));

  void onMinimumAmountChanged(double amount) =>
      emit(state.copyWith(minimumAmount: amount));

  void onDescriptionChanged(String? description) =>
      emit(state.copyWith(description: description));

  void onSubmit() async {
    final createPayoutSessionResultOrError =
        await _newBatchPayoutSessionDialogRepository.createBatchPayoutSession(
          input: state.toInput,
        );
    final saveState = createPayoutSessionResultOrError;
    emit(state.copyWith(saveState: saveState));
  }
}
