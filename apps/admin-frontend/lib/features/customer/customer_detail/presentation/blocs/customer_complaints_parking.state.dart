part of 'customer_complaints_parking.cubit.dart';

@freezed
sealed class CustomerComplaintsParkingState
    with _$CustomerComplaintsParkingState {
  const factory CustomerComplaintsParkingState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerComplaintsParking> complaintsResponse,
    String? customerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ParkingSupportRequestSort> sorting,
    @Default([]) List<Enum$ComplaintStatus> filterStatus,
  }) = _CustomerComplaintsParkingState;
}
