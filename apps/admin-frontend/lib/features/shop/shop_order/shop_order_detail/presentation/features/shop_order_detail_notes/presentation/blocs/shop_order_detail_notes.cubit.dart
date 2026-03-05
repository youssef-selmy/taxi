import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/data/repositories/shop_order_detail_notes_repository.dart';

part 'shop_order_detail_notes.state.dart';
part 'shop_order_detail_notes.cubit.freezed.dart';

class ShopOrderDetailNotesBloc extends Cubit<ShopOrderDetailNotesState> {
  final ShopOrderDetailNotesRepository _shopOrderDetailNoteRepository =
      locator<ShopOrderDetailNotesRepository>();

  ShopOrderDetailNotesBloc() : super(ShopOrderDetailNotesState());

  void onStarted(String shopOrderId) {
    emit(state.copyWith(shopOrderId: shopOrderId));
    _fetchShopOrderDetailNotes();
  }

  Future<void> _fetchShopOrderDetailNotes() async {
    emit(
      state.copyWith(shopOrderDetailNotesState: const ApiResponse.loading()),
    );

    final shopOrderDetailNotesOrError = await _shopOrderDetailNoteRepository
        .getShopOrderNotes(id: state.shopOrderId!);

    emit(
      state.copyWith(shopOrderDetailNotesState: shopOrderDetailNotesOrError),
    );
  }

  void onNoteChanged(String p1) {
    emit(state.copyWith(note: p1));
  }

  void onSubmitNote() async {
    if (state.note != null && state.note!.isNotEmpty) {
      emit(state.copyWith(createOrderNoteState: const ApiResponse.loading()));
      final createOrderNoteResponse = await _shopOrderDetailNoteRepository
          .createShopOrderNote(note: state.note!, orderId: state.shopOrderId!);
      emit(
        state.copyWith(createOrderNoteState: createOrderNoteResponse, note: ""),
      );
      _fetchShopOrderDetailNotes();
    }
  }
}
