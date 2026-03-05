import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/graphql/taxi_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/repositories/taxi_order_detail_notes_repository.dart';

part 'taxi_order_detail_notes.state.dart';
part 'taxi_order_detail_notes.cubit.freezed.dart';

class TaxiOrderDetailNotesBloc extends Cubit<TaxiOrderDetailNotesState> {
  final TaxiOrderDetailNotesRepository _taxiOrderDetailNoteRepository =
      locator<TaxiOrderDetailNotesRepository>();

  TaxiOrderDetailNotesBloc() : super(TaxiOrderDetailNotesState());

  void onStarted(String orderId) {
    emit(state.copyWith(orderId: orderId));
    _fetchOrderNotes();
  }

  Future<void> _fetchOrderNotes() async {
    emit(state.copyWith(orderDetailNotesState: const ApiResponse.loading()));
    final orderNotesOrError = await _taxiOrderDetailNoteRepository
        .getTaxiOrderNotes(orderId: state.orderId!);
    emit(state.copyWith(orderDetailNotesState: orderNotesOrError));
  }

  Future<void> createNote() async {
    if (state.note == null || state.note!.isEmpty) {
      return;
    }
    emit(state.copyWith(createOrderNoteState: const ApiResponse.loading()));
    final orderNotesOrError = await _taxiOrderDetailNoteRepository
        .createTaxiOrderNote(
          input: Input$CreateTaxiOrderNoteInput(
            orderId: state.orderId!,
            note: state.note!,
          ),
        );
    emit(state.copyWith(createOrderNoteState: orderNotesOrError));
    _fetchOrderNotes();
  }

  void onNoteChange(String value) {
    emit(state.copyWith(note: value));
  }
}
