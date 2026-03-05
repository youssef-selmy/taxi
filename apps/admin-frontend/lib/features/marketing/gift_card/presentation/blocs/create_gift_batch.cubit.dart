import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/repositories/gift_card_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'create_gift_batch.state.dart';
part 'create_gift_batch.cubit.freezed.dart';

class CreateGiftBatchBloc extends Cubit<CreateGiftBatchState> {
  final GiftCardRepository _giftCardRepository = locator<GiftCardRepository>();

  CreateGiftBatchBloc() : super(CreateGiftBatchState.initial());

  void onStarted() {
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void onSave() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _giftCardRepository.create(
      input: Input$CreateGiftBatchInput(
        name: state.name!,
        currency: state.currency,
        amount: state.amount,
        quantity: state.count,
        availableFrom: state.availableFrom,
        expireAt: state.expireAt,
      ),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void onAmountChanged(double? p1) {
    emit(state.copyWith(amount: p1 ?? 0));
  }

  void onCurrencyChanged(String? p1) {
    emit(state.copyWith(currency: p1!));
  }

  void onNameChanged(String p1) {
    emit(state.copyWith(name: p1));
  }

  void onQuantityChanged(int? p1) {
    emit(state.copyWith(count: p1 ?? 0));
  }

  void onAvailabilityChanged((DateTime, DateTime)? p1) {
    emit(state.copyWith(availableFrom: p1!.$1, expireAt: p1.$2));
  }
}
