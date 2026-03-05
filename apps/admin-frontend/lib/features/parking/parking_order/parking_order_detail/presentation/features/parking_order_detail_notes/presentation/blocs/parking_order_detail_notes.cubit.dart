import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/graphql/parking_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/repositories/parking_order_detail_notes_repository.dart';

part 'parking_order_detail_notes.state.dart';
part 'parking_order_detail_notes.cubit.freezed.dart';

class ParkingOrderDetailNotesBloc extends Cubit<ParkingOrderDetailNotesState> {
  final ParkingOrderDetailNotesRepository _parkingOrderDetailNoteRepository =
      locator<ParkingOrderDetailNotesRepository>();

  ParkingOrderDetailNotesBloc() : super(ParkingOrderDetailNotesState());

  void onStarted(String parkingOrderId) {
    emit(ParkingOrderDetailNotesState(orderId: parkingOrderId));
    _fetchParkingOrderDetailNotes();
  }

  Future<void> _fetchParkingOrderDetailNotes() async {
    emit(state.copyWith(parkingOrderNotesState: const ApiResponse.loading()));

    final parkingOrderDetailNotesOrError =
        await _parkingOrderDetailNoteRepository.getParkingOrderDetailNotes(
          parkingOrderId: state.orderId!,
        );

    emit(
      state.copyWith(parkingOrderNotesState: parkingOrderDetailNotesOrError),
    );
  }

  void onSendNote() {
    if (state.note.isNotEmpty) {
      _sendNote();
    }
  }

  void onNoteChanged(String value) {
    emit(state.copyWith(note: value));
  }

  void _sendNote() async {
    emit(state.copyWith(createOrderNoteState: const ApiResponse.loading()));

    final createNoteOrError = await _parkingOrderDetailNoteRepository
        .createParkingOrderNote(
          parkingOrderId: state.orderId!,
          note: state.note,
        );
    if (createNoteOrError.isLoaded) {
      emit(state.copyWith(note: '', createOrderNoteState: createNoteOrError));
      _fetchParkingOrderDetailNotes();
    }
  }
}
