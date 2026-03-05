import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/graphql/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/repositories/gift_card_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'gift_card_details.state.dart';
part 'gift_card_details.cubit.freezed.dart';

class GiftCardDetailsBloc extends Cubit<GiftCardDetailsState> {
  final GiftCardRepository _giftCardRepository = locator<GiftCardRepository>();

  GiftCardDetailsBloc() : super(GiftCardDetailsState());

  void onStarted({required String batchId}) {
    emit(state.copyWith(batchId: batchId));
    _getBatchInfo();
    _getCodeList();
  }

  void _getBatchInfo() async {
    emit(state.copyWith(batch: const ApiResponse.loading()));
    final result = await _giftCardRepository.getOne(state.batchId!);
    final networkState = result;
    emit(state.copyWith(batch: networkState));
  }

  void _getCodeList() async {
    emit(state.copyWith(giftCodes: const ApiResponse.loading()));
    final result = await _giftCardRepository.getGiftCodes(
      batchId: state.batchId!,
      paging: state.paging,
      sort: state.sort,
    );
    final networkState = result;
    emit(state.copyWith(giftCodes: networkState));
  }

  void onExportGiftCodes() async {
    emit(state.copyWith(export: const ApiResponse.loading()));
    final result = await _giftCardRepository.exportGiftCodes(
      batchId: state.batchId!,
    );
    final networkState = result;
    emit(state.copyWith(export: networkState));
  }

  void resetExportState() {
    emit(state.copyWith(export: const ApiResponse.initial()));
  }

  void onGiftCodesPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _getCodeList();
  }
}
