part of 'email_provider_list.cubit.dart';

@freezed
sealed class EmailProviderListState with _$EmailProviderListState {
  const factory EmailProviderListState({
    required ApiResponse<Query$emailProviders> emailProviders,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$EmailProviderSort> sorting,
  }) = _EmailProviderListState;

  factory EmailProviderListState.initial() =>
      EmailProviderListState(emailProviders: const ApiResponse.initial());
}
