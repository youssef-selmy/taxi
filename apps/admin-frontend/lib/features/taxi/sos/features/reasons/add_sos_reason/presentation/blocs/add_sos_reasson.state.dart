part of 'add_sos_reasson.cubit.dart';

@freezed
sealed class AddSosReassonState with _$AddSosReassonState {
  const factory AddSosReassonState({
    @Default(ApiResponseInitial()) ApiResponse<void> sosReasonDetailNetwork,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
    String? title,
    String? sosReassonId,
    bool? isActive,
  }) = _AddSosReassonState;
}
