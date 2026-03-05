import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_notes.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_notes_repository.dart';

part 'park_spot_detail_notes.state.dart';
part 'park_spot_detail_notes.cubit.freezed.dart';

class ParkSpotDetailNotesBloc extends Cubit<ParkSpotDetailNotesState> {
  final ParkSpotDetailNotesRepository _parkSpotDetailNotesRepository =
      locator<ParkSpotDetailNotesRepository>();

  ParkSpotDetailNotesBloc() : super(ParkSpotDetailNotesState());

  void onStarted({required String parkSpotId}) {
    emit(state.copyWith(parkSpotId: parkSpotId));
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    emit(state.copyWith(parkSpotNotesState: const ApiResponse.loading()));
    final notesOrError = await _parkSpotDetailNotesRepository.getNotes(
      parkSpotId: state.parkSpotId!,
    );
    final notesState = notesOrError;
    emit(state.copyWith(parkSpotNotesState: notesState));
  }

  void onNoteChanged(String note) {
    emit(state.copyWith(note: note));
  }

  void onSubmitNote() async {
    final noteOrError = await _parkSpotDetailNotesRepository.createNote(
      parkSpotId: state.parkSpotId!,
      note: state.note!,
    );
    if (noteOrError.isLoaded) {
      _fetchNotes();
    }
  }
}
