import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/features/shop_insert_transaction/data/repositories/shop_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_insert_transaction.state.dart';
part 'shop_insert_transaction.bloc.freezed.dart';

class ShopInsertTransactionBloc extends Cubit<ShopInsertTransactionState> {
  final ShopInsertTransactionRepository _shopInsertTransactionRepository =
      locator<ShopInsertTransactionRepository>();

  ShopInsertTransactionBloc()
    : super(ShopInsertTransactionState.initial(shopId: "0"));

  void onStarted({required String shopId}) {
    emit(ShopInsertTransactionState.initial(shopId: shopId));
  }

  Future<void> onSubmitted() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state.formKey.currentState?.save();
      final transactionOrError = await _shopInsertTransactionRepository
          .insertTransaction(
            shopId: state.shopId!,
            type: state.type!,
            creditType: state.rechargeType,
            debitType: state.deductType,
            currency: state.currency!,
            amount: state.amount!,
            referenceNumber: state.referenceNumber!,
            description: state.description!,
          );
      final transactionState = transactionOrError;
      emit(state.copyWith(saveState: transactionState));
    }
  }

  void onTransactionTypeChanged((Enum$TransactionType, Enum)? value) {
    emit(
      state.copyWith(
        type: value?.$1,
        rechargeType: value?.$1 == Enum$TransactionType.Credit
            ? value?.$2 as Enum$ShopTransactionCreditType?
            : null,
        deductType: value?.$1 == Enum$TransactionType.Debit
            ? value?.$2 as Enum$ShopTransactionDebitType?
            : null,
      ),
    );
  }

  void onCurrencyChanged(String? value) =>
      emit(state.copyWith(currency: value));

  void onAmountChanged(String p0) =>
      emit(state.copyWith(amount: double.tryParse(p0)));

  void onReferenceNumberChanged(String value) =>
      emit(state.copyWith(referenceNumber: value));

  void onDescriptionChanged(String value) =>
      emit(state.copyWith(description: value));
}
