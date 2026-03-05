import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/features/driver_insert_transaction/data/repositories/driver_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_insert_transaction.state.dart';
part 'driver_insert_transaction.bloc.freezed.dart';

class DriverInsertTransactionBloc extends Cubit<DriverInsertTransactionState> {
  final DriverInsertTransactionRepository _driverInsertTransactionRepository =
      locator<DriverInsertTransactionRepository>();

  DriverInsertTransactionBloc()
    : super(DriverInsertTransactionState.initial(driverId: "0"));

  void onStarted({required String driverId}) {
    emit(DriverInsertTransactionState.initial(driverId: driverId));
  }

  Future<void> onSubmitted() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state.formKey.currentState?.save();
      final transactionOrError = await _driverInsertTransactionRepository
          .insertTransaction(
            driverId: state.driverId!,
            action: state.action!,
            rechargeType: state.rechargeType,
            deductType: state.deductType,
            currency: state.currency!,
            amount: state.amount!,
            referenceNumber: state.referenceNumber!,
            description: state.description!,
          );
      final transactionState = transactionOrError;
      emit(state.copyWith(saveState: transactionState));
    }
  }

  void onTransactionTypeChanged((Enum$TransactionAction, Enum)? value) {
    emit(
      state.copyWith(
        action: value?.$1,
        rechargeType: value?.$1 == Enum$TransactionAction.Recharge
            ? value?.$2 as Enum$DriverRechargeTransactionType?
            : null,
        deductType: value?.$1 == Enum$TransactionAction.Deduct
            ? value?.$2 as Enum$DriverDeductTransactionType?
            : null,
      ),
    );
  }

  void onCurrencyChanged(String? value) {
    emit(state.copyWith(currency: value));
  }

  void onAmountChanged(String p0) {
    emit(state.copyWith(amount: double.tryParse(p0)));
  }

  void onReferenceNumberChanged(String value) {
    emit(state.copyWith(referenceNumber: value));
  }

  void onDescriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }
}
