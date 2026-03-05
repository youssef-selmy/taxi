part of 'driver_settings.bloc.dart';

@freezed
sealed class DriverSettingsState with _$DriverSettingsState {
  const factory DriverSettingsState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverShiftRules> driverShiftRulesState,
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDocuments> driverDocumentsState,
    @Default([]) List<Fragment$driverDocument> driverDocuments,
    @Default([]) List<Fragment$driverShiftRule> driverShiftRules,
    @Default([]) List<String> driverShiftDeleteIds,
    @Default([]) List<String> driverDocumentDeleteIds,
    @Default([]) List<String> driverDocumentRetentionPolicyDeleteIds,
  }) = _DriverSettingsState;
}
