part of 'email_template_details.cubit.dart';

@freezed
sealed class EmailTemplateDetailsState with _$EmailTemplateDetailsState {
  const factory EmailTemplateDetailsState({
    required ApiResponse<Fragment$emailTemplateDetails?> emailTemplate,
    required ApiResponse<void> networkStateSave,
    String? emailTemplateId,
    String? name,
    Enum$EmailEventType? eventType,
    String? subject,
    @Default(Enum$EmailContentSource.Inline)
    Enum$EmailContentSource contentSource,
    String? bodyHtml,
    String? bodyPlainText,
    String? providerTemplateId,
    @Default(true) bool isActive,
    String? locale,
    String? cc,
  }) = _EmailTemplateDetailsState;

  factory EmailTemplateDetailsState.initial() => EmailTemplateDetailsState(
    emailTemplate: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
  );

  const EmailTemplateDetailsState._();

  Input$EmailTemplateInput toInput() => Input$EmailTemplateInput(
    name: name!,
    eventType: eventType!,
    subject: subject!,
    contentSource: contentSource,
    bodyHtml: contentSource == Enum$EmailContentSource.Inline ? bodyHtml : null,
    bodyPlainText: contentSource == Enum$EmailContentSource.Inline
        ? bodyPlainText
        : null,
    providerTemplateId:
        contentSource == Enum$EmailContentSource.ProviderTemplate
        ? providerTemplateId
        : null,
    isActive: isActive,
    locale: locale,
    cc: cc,
  );
}
