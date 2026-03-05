part of 'email_template_list.cubit.dart';

@freezed
sealed class EmailTemplateListState with _$EmailTemplateListState {
  const factory EmailTemplateListState({
    required ApiResponse<Query$emailTemplates> emailTemplates,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$EmailTemplateSort> sorting,
  }) = _EmailTemplateListState;

  factory EmailTemplateListState.initial() =>
      EmailTemplateListState(emailTemplates: const ApiResponse.initial());
}
