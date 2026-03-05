part of 'create_gift_batch.cubit.dart';

@freezed
sealed class CreateGiftBatchState with _$CreateGiftBatchState {
  const factory CreateGiftBatchState({
    String? name,
    required String currency,
    @Default(0) double amount,
    @Default(0) int count,
    required DateTime availableFrom,
    required DateTime expireAt,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
  }) = _CreateGiftBatchState;

  // initial state
  factory CreateGiftBatchState.initial() => CreateGiftBatchState(
    currency: Env.defaultCurrency,
    availableFrom: DateTime.now(),
    expireAt: DateTime.now().add(const Duration(days: 180)),
  );
}
