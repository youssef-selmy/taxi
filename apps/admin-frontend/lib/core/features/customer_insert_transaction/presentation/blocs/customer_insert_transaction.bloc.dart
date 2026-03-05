import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/features/customer_insert_transaction/data/repositories/customer_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customer_insert_transaction.state.dart';
part 'customer_insert_transaction.bloc.freezed.dart';

class CustomerInsertTransactionBloc
    extends Cubit<CustomerInsertTransactionState> {
  final CustomerInsertTransactionRepository
  _customerInsertTransactionRepository =
      locator<CustomerInsertTransactionRepository>();

  CustomerInsertTransactionBloc()
    : super(CustomerInsertTransactionState.initial(customerId: "0"));

  void onStarted({required String customerId}) {
    emit(CustomerInsertTransactionState.initial(customerId: customerId));
  }

  Future<void> onSubmitted() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state.formKey.currentState?.save();
      final transactionOrError = await _customerInsertTransactionRepository
          .insertTransaction(
            customerId: state.customerId!,
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
            ? value?.$2 as Enum$RiderRechargeTransactionType?
            : null,
        deductType: value?.$1 == Enum$TransactionAction.Deduct
            ? value?.$2 as Enum$RiderDeductTransactionType?
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
