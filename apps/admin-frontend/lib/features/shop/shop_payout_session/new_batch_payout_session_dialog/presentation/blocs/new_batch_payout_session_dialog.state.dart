part of 'new_batch_payout_session_dialog.cubit.dart';

@freezed
sealed class NewBatchPayoutSessionDialogState
    with _$NewBatchPayoutSessionDialogState {
  const factory NewBatchPayoutSessionDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$payoutMethods> payoutMethodsState,
    @Default([]) List<String> selectedPayoutMethodIds,
    String? currency,
    @Default(0) double minimumAmount,
    String? description,
    @Default(0) double totalPayoutAmount,
    Enum$AppType? appType,
    @Default(ApiResponseInitial()) ApiResponse<void> saveState,
  }) = _NewBatchPayoutSessionDialogState;

  const NewBatchPayoutSessionDialogState._();

  Input$CreatePayoutSessionInput get toInput => Input$CreatePayoutSessionInput(
    payoutMethodIds: selectedPayoutMethodIds,
    minimumAmount: minimumAmount,
    currency: currency!,
    description: description,
    appType: appType!,
  );
}
