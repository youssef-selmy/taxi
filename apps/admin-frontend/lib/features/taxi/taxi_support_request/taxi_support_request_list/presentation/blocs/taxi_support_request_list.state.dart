part of 'taxi_support_request_list.cubit.dart';

@freezed
sealed class TaxiSupportRequestState with _$TaxiSupportRequestState {
  const factory TaxiSupportRequestState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$taxiSupportRequests> supportRequest,
    Input$OffsetPaging? paging,
    required List<Input$TaxiSupportRequestSort> sortFields,
    @Default([
      Enum$ComplaintStatus.Submitted,
      Enum$ComplaintStatus.UnderInvestigation,
    ])
    List<Enum$ComplaintStatus> filterStatus,
  }) = _TaxiSupportRequestState;

  factory TaxiSupportRequestState.initial() => TaxiSupportRequestState(
    sortFields: [
      Input$TaxiSupportRequestSort(
        field: Enum$TaxiSupportRequestSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );
}
