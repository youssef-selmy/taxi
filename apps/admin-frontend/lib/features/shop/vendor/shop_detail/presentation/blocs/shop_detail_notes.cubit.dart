import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_notes.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_notes_repository.dart';

part 'shop_detail_notes.state.dart';
part 'shop_detail_notes.cubit.freezed.dart';

class ShopDetailNotesBloc extends Cubit<ShopDetailNotesState> {
  final ShopDetailNotesRepository _shopDetailNotesRepository =
      locator<ShopDetailNotesRepository>();

  ShopDetailNotesBloc() : super(ShopDetailNotesState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    emit(state.copyWith(shopNotesState: const ApiResponse.loading()));
    final notesOrError = await _shopDetailNotesRepository.getNotes(
      shopId: state.shopId!,
    );
    final notesState = notesOrError;
    emit(state.copyWith(shopNotesState: notesState));
  }

  void onNoteChanged(String note) {
    emit(state.copyWith(note: note));
  }

  void onSubmitNote() async {
    if (state.note == null || state.note!.isEmpty) {
      return;
    }
    emit(state.copyWith(createShopNoteState: const ApiResponse.loading()));
    final noteOrError = await _shopDetailNotesRepository.createNote(
      shopId: state.shopId!,
      note: state.note!,
    );
    if (noteOrError.isLoaded) {
      emit(state.copyWith(createShopNoteState: noteOrError, note: null));
      _fetchNotes();
    }
  }
}
