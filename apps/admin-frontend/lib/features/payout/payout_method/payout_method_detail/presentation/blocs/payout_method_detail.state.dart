part of 'payout_method_detail.cubit.dart';

@freezed
sealed class PayoutMethodDetailState with _$PayoutMethodDetailState {
  const factory PayoutMethodDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$payoutMethodDetail?> payoutMethodState,
    @Default(ApiResponseInitial()) ApiResponse<void> saveState,
    String? id,
    String? name,
    Enum$PayoutMethodType? type,
    String? saltKey,
    required String currency,
    String? privateKey,
    String? publicKey,
    String? merchantId,
    String? description,
    Fragment$Media? media,
  }) = _PayoutMethodDetailState;

  const PayoutMethodDetailState._();

  // initial
  factory PayoutMethodDetailState.initial() =>
      PayoutMethodDetailState(currency: Env.defaultCurrency);

  Input$CreatePayoutMethodInput get toInput => Input$CreatePayoutMethodInput(
    name: name!,
    description: description!,
    currency: currency,
    type: type!,
    merchantId: merchantId,
    privateKey: privateKey,
    publicKey: publicKey,
    saltKey: saltKey,
    mediaId: media?.id,
  );
}
