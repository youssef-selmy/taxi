part of 'park_spot_detail_notes.cubit.dart';

@freezed
sealed class ParkSpotDetailNotesState with _$ParkSpotDetailNotesState {
  const factory ParkSpotDetailNotesState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkSpotNotes> parkSpotNotesState,
    String? parkSpotId,
    String? note,
    @Default(ApiResponseInitial()) ApiResponse<void> createOrderNoteState,
  }) = _ParkSpotDetailNotesState;
}
