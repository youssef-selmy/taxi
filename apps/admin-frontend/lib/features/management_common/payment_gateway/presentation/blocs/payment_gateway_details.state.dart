part of 'payment_gateway_details.cubit.dart';

@freezed
sealed class PaymentGatewayDetailsState with _$PaymentGatewayDetailsState {
  const factory PaymentGatewayDetailsState({
    required ApiResponse<Fragment$paymentGatewayDetails?> paymentGateway,
    required ApiResponse<void> networkStateSave,
    String? paymentGatewayId,
    String? name,
    @Default(true) bool isEnabled,
    Enum$PaymentGatewayType? type,
    String? privateKey,
    String? publicKey,
    String? saltKey,
    String? merchantId,
    Fragment$Media? media,
  }) = _PaymentGatewayDetailsState;

  factory PaymentGatewayDetailsState.initial() => PaymentGatewayDetailsState(
    paymentGateway: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
  );

  const PaymentGatewayDetailsState._();

  Input$CreatePaymentGatewayInput toCreateInput() {
    return Input$CreatePaymentGatewayInput(
      title: name!,
      type: type!,
      enabled: isEnabled,
      privateKey: privateKey!,
      publicKey: publicKey,
      saltKey: saltKey,
      merchantId: merchantId,
      mediaId: media?.id,
    );
  }

  Input$UpdatePaymentGatewayInput toUpdateInput() {
    return Input$UpdatePaymentGatewayInput(
      title: name!,
      type: type!,
      enabled: isEnabled,
      privateKey: privateKey!,
      publicKey: publicKey,
      saltKey: saltKey,
      merchantId: merchantId,
      mediaId: media?.id,
    );
  }
}
