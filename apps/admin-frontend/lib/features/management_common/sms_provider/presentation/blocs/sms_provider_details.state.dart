part of 'sms_provider_details.cubit.dart';

@freezed
sealed class SmsProviderDetailsState with _$SmsProviderDetailsState {
  const factory SmsProviderDetailsState({
    required ApiResponse<Fragment$smsProviderDetails?> smsProvider,
    required ApiResponse<void> networkStateSave,
    @Default(ApiResponse.initial()) ApiResponse<void> networkStateSetDefault,
    String? smsProviderId,
    String? name,
    Enum$SMSProviderType? type,
    @Default(true) bool isDefault,
    String? accountId,
    String? authToken,
    String? fromNumber,
    String? smsType,
    String? verificationTemplate,
    String? callMaskingNumber,
    @Default(false) bool callMaskingEnabled,
  }) = _SmsProviderDetailsState;

  factory SmsProviderDetailsState.initial() => SmsProviderDetailsState(
    smsProvider: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
  );

  const SmsProviderDetailsState._();

  Input$SMSProviderInput toInput() => Input$SMSProviderInput(
    name: name!,
    type: type!,
    isDefault: isDefault,
    accountId: accountId,
    authToken: authToken,
    fromNumber: fromNumber,
    smsType: smsType,
    verificationTemplate: verificationTemplate,
    callMaskingNumber: callMaskingNumber,
    callMaskingEnabled: callMaskingEnabled,
  );
}
