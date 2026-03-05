part of 'driver_detail_notes.bloc.dart';

@freezed
sealed class DriverDetailNotesState with _$DriverDetailNotesState {
  const factory DriverDetailNotesState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDetailNotes> driverDetailNotesState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$createDriverNote> createDriverNoteState,
    String? driverId,
    String? note,
  }) = _DriverDetailNotesState;

  const DriverDetailNotesState._();
}
