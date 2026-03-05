part of 'taxi_order_detail_notes.cubit.dart';

@freezed
sealed class TaxiOrderDetailNotesState with _$TaxiOrderDetailNotesState {
  const factory TaxiOrderDetailNotesState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$taxiOrderNotes> orderDetailNotesState,
    String? note,
    String? orderId,
    @Default(ApiResponseInitial()) ApiResponse<void> createOrderNoteState,
  }) = _TaxiOrderDetailNoteState;
}
