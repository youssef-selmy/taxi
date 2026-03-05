part of 'email_provider_details.cubit.dart';

@freezed
sealed class EmailProviderDetailsState with _$EmailProviderDetailsState {
  const factory EmailProviderDetailsState({
    required ApiResponse<Fragment$emailProviderDetails?> emailProvider,
    required ApiResponse<void> networkStateSave,
    @Default(ApiResponse.initial()) ApiResponse<void> networkStateSetDefault,
    String? emailProviderId,
    String? name,
    Enum$EmailProviderType? type,
    @Default(true) bool isDefault,
    String? apiKey,
    String? fromEmail,
    String? fromName,
    String? replyToEmail,
  }) = _EmailProviderDetailsState;

  factory EmailProviderDetailsState.initial() => EmailProviderDetailsState(
    emailProvider: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
  );

  const EmailProviderDetailsState._();

  Input$EmailProviderInput toInput() => Input$EmailProviderInput(
    name: name!,
    type: type!,
    isDefault: isDefault,
    apiKey: apiKey,
    fromEmail: fromEmail,
    fromName: fromName,
    replyToEmail: replyToEmail,
  );
}
