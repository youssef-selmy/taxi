part of 'sos.cubit.dart';

@freezed
sealed class SosState with _$SosState {
  const factory SosState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$distressSignals> distressSignals,
    Input$OffsetPaging? paging,
    required List<Input$DistressSignalSort> sortFields,
    @Default([Enum$SOSStatus.Submitted, Enum$SOSStatus.UnderReview])
    List<Enum$SOSStatus> filterStatus,
  }) = _SosState;

  factory SosState.initial() => SosState(
    sortFields: [
      Input$DistressSignalSort(
        field: Enum$DistressSignalSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );
}
