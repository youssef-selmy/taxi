part of 'sms_provider_list.cubit.dart';

@freezed
sealed class SmsProviderListState with _$SmsProviderListState {
  const factory SmsProviderListState({
    required ApiResponse<Query$smsProviders> smsProviders,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$SMSProviderSort> sorting,
  }) = _SmsProviderListState;

  factory SmsProviderListState.initial() =>
      SmsProviderListState(smsProviders: const ApiResponse.initial());
}
