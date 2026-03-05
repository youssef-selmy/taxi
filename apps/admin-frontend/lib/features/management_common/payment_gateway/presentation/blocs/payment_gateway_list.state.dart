part of 'payment_gateway_list.cubit.dart';

@freezed
sealed class PaymentGatewayListState with _$PaymentGatewayListState {
  const factory PaymentGatewayListState({
    required ApiResponse<Query$paymentGateways> paymentGateways,
    String? search,
    @Default([]) List<Input$PaymentGatewaySort> sort,
    Input$OffsetPaging? paging,
  }) = _PaymentGatewayListState;

  factory PaymentGatewayListState.initial() =>
      PaymentGatewayListState(paymentGateways: const ApiResponse.initial());
}
