import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/data/repositories/admin_accounting_insert_transaction_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'admin_accounting_insert_transaction.state.dart';
part 'admin_accounting_insert_transaction.bloc.freezed.dart';

class AdminAccountingInsertTransactionBloc
    extends Cubit<AdminAccountingInsertTransactionState> {
  final AdminAccountingInsertTransactionRepository
  _adminAccountingInsertTransactionRepository =
      locator<AdminAccountingInsertTransactionRepository>();

  AdminAccountingInsertTransactionBloc()
    : super(AdminAccountingInsertTransactionState.initial());

  void onStarted() {}

  Future<void> onSubmitted() async {
    emit(state.copyWith(saveState: const ApiResponse.loading()));
    final transactionOrError = await _adminAccountingInsertTransactionRepository
        .insertTransaction(
          input: Input$ProviderTransactionInput(
            amount: state.amount!,
            currency: state.currency!,
            description: state.description,
            refrenceNumber: state.referenceNumber,
            action: state.action!,
            deductType: state.debitType,
            rechargeType: state.creditType,
            expenseType: state.expenseType,
          ),
        );
    final transactionState = transactionOrError;
    emit(state.copyWith(saveState: transactionState));
  }

  void onCurrencyChanged(String? value) {
    emit(state.copyWith(currency: value!));
  }

  void onAmountChanged(String p0) {
    emit(state.copyWith(amount: double.tryParse(p0) ?? 0));
  }

  void onReferenceNumberChanged(String value) {
    emit(state.copyWith(referenceNumber: value));
  }

  void onDescriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void onActionChanged(Enum$TransactionAction? value) {
    emit(state.copyWith(action: value));
  }

  void onDebitTypeChanged(Enum$ProviderDeductTransactionType? p1) {
    emit(state.copyWith(debitType: p1));
  }

  void onExpenseTypeChanged(Enum$ProviderExpenseType? p1) {
    emit(state.copyWith(expenseType: p1));
  }

  void onCreditTypeChanged(Enum$ProviderRechargeTransactionType? p1) {
    emit(state.copyWith(creditType: p1));
  }
}
