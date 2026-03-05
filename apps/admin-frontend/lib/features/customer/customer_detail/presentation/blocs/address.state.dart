part of 'address.cubit.dart';

@freezed
sealed class AddressState with _$AddressState {
  const factory AddressState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerAddresses> networkState,
    Input$OffsetPaging? paging,
    String? customerId,
  }) = _AddressState;
}
