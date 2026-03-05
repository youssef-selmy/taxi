import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/features/parking_insert_transaction/data/repositories/parking_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_insert_transaction.state.dart';
part 'parking_insert_transaction.bloc.freezed.dart';

class ParkingInsertTransactionBloc
    extends Cubit<ParkingInsertTransactionState> {
  final ParkingInsertTransactionRepository _parkingInsertTransactionRepository =
      locator<ParkingInsertTransactionRepository>();

  ParkingInsertTransactionBloc()
    : super(ParkingInsertTransactionState.initial(parkingId: "0"));

  void onStarted({required String parkingId}) {
    emit(ParkingInsertTransactionState.initial(parkingId: parkingId));
  }

  Future<void> onSubmitted() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state.formKey.currentState?.save();
      final transactionOrError = await _parkingInsertTransactionRepository
          .insertTransaction(
            parkingId: state.parkingId!,
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
            ? value?.$2 as Enum$ParkingTransactionCreditType?
            : null,
        deductType: value?.$1 == Enum$TransactionType.Debit
            ? value?.$2 as Enum$ParkingTransactionDebitType?
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
