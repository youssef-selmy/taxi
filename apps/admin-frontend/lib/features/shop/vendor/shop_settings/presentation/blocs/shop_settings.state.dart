part of 'shop_settings.bloc.dart';

@freezed
sealed class ShopSettingsState with _$ShopSettingsState {
  const factory ShopSettingsState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$shopDocuments> shopDocumentsState,
    @Default([]) List<Fragment$shopDocument> shopDocuments,
    @Default([]) List<String> shopDocumentDeleteIds,
    @Default([]) List<String> shopDocumentRetentionPolicyDeleteIds,
  }) = _ShopSettingsState;
}
