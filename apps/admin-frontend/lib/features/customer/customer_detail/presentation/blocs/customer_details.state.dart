part of 'customer_details.cubit.dart';

@freezed
sealed class CustomerDetailsState with _$CustomerDetailsState {
  const factory CustomerDetailsState({
    @Default(ApiResponse<Fragment$customerDetails>.initial())
    ApiResponse<Fragment$customerDetails> customerDetailsState,
    @Default(ApiResponse.initial()) ApiResponse<void> deleteUserState,
  }) = _CustomerDetailsState;
}
