part of 'parking_order_detail_notes.cubit.dart';

@freezed
sealed class ParkingOrderDetailNotesState with _$ParkingOrderDetailNotesState {
  const factory ParkingOrderDetailNotesState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getParkingOrderNotes> parkingOrderNotesState,
    String? orderId,
    @Default('') String note,
    @Default(ApiResponseInitial()) ApiResponse<void> createOrderNoteState,
  }) = _ParkingOrderDetailNotesState;
}
