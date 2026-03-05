import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_note.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_details_repository.dart';

part 'customer_notes.state.dart';
part 'customer_notes.cubit.freezed.dart';

class CustomerNotesBloc extends Cubit<CustomerNotesState> {
  final CustomerDetailsRepository _customerDetailsRepository =
      locator<CustomerDetailsRepository>();

  CustomerNotesBloc()
    : super(CustomerNotesState(notesState: const ApiResponse.initial()));

  void onStarted({required String customerId}) {
    _fetchCustomerNotes(customerId: customerId);
  }

  void onNoteChanged({required String note}) {
    emit(state.copyWith(note: note));
  }

  Future onAddNote() async {
    final result = await _customerDetailsRepository.addCustomerNote(
      note: state.note!,
      customerId: state.customerId!,
    );
    return result.fold(
      (l, {failure}) => emit(state.copyWith(notesState: ApiResponse.error(l))),
      (note) => emit(
        state.copyWith(
          notesState: ApiResponse.loaded(
            state.notesState.data!.toList()..add(note),
          ),
        ),
      ),
    );
  }

  void _fetchCustomerNotes({required String customerId}) async {
    emit(
      state.copyWith(
        notesState: const ApiResponse.loading(),
        customerId: customerId,
      ),
    );
    final notes = await _customerDetailsRepository.getCustomerNotes(
      customerId: customerId,
    );
    notes.fold(
      (l, {failure}) => emit(state.copyWith(notesState: ApiResponse.error(l))),
      (notes) => emit(state.copyWith(notesState: ApiResponse.loaded(notes))),
    );
  }
}
