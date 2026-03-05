part of 'customer_complaints_taxi.cubit.dart';

@freezed
sealed class CustomerComplaintsTaxiState with _$CustomerComplaintsTaxiState {
  const factory CustomerComplaintsTaxiState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerComplaintsTaxi> complaintsResponse,
    String? customerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$TaxiSupportRequestSort> sortFields,
    @Default([]) List<Enum$ComplaintStatus> filterStatus,
  }) = _CustomerComplaintsTaxiState;
}
