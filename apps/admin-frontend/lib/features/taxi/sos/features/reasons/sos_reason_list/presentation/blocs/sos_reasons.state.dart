part of 'sos_reasons.cubit.dart';

@freezed
sealed class SosReasonsState with _$SosReasonsState {
  const factory SosReasonsState({
    required ApiResponse<Query$sosReasons> sosReasons,
    String? search,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$SOSReasonSort> sorting,
  }) = _SosReasonsState;

  factory SosReasonsState.initial() =>
      SosReasonsState(sosReasons: const ApiResponse.initial());
}
