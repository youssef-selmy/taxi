import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/graphql/driver_detail_notes.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/repositories/driver_detail_notes_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_detail_notes.state.dart';
part 'driver_detail_notes.bloc.freezed.dart';

class DriverDetailNotesBloc extends Cubit<DriverDetailNotesState> {
  final DriverDetailNotesRepository _driverDetailNotesRepository =
      locator<DriverDetailNotesRepository>();

  DriverDetailNotesBloc() : super(DriverDetailNotesState());

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));

    _fetchDriverNotes();
  }

  Future<void> _fetchDriverNotes() async {
    emit(state.copyWith(driverDetailNotesState: const ApiResponse.loading()));

    final driverNotesOrError = await _driverDetailNotesRepository
        .getDriverNotes(driverId: state.driverId!);

    emit(state.copyWith(driverDetailNotesState: driverNotesOrError));
  }

  Future<void> createDriverNote() async {
    emit(state.copyWith(createDriverNoteState: const ApiResponse.loading()));

    final createDriverNoteOrError = await _driverDetailNotesRepository
        .createDriverNote(
          input: Input$CreateOneDriverNoteInput(
            driverNote: Input$CreateDriverNoteInput(
              driverId: state.driverId!,
              note: state.note!,
            ),
          ),
        );

    if (createDriverNoteOrError.isLoaded) {
      _fetchDriverNotes();
      emit(
        state.copyWith(
          note: null,
          createDriverNoteState: createDriverNoteOrError,
        ),
      );
    }
  }

  void onNoteChange(String note) {
    emit(state.copyWith(note: note));
  }
}
