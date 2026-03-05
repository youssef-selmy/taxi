part of 'customer_notes.cubit.dart';

@freezed
sealed class CustomerNotesState with _$CustomerNotesState {
  const factory CustomerNotesState({
    required ApiResponse<List<Fragment$customerNote>> notesState,
    String? customerId,
    String? note,
  }) = _CustomerNotesState;
}
