part of 'admin_accounting_insert_transaction.bloc.dart';

@freezed
sealed class AdminAccountingInsertTransactionState
    with _$AdminAccountingInsertTransactionState {
  const factory AdminAccountingInsertTransactionState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$adminTransactionListItem> saveState,
    Enum$TransactionAction? action,
    Enum$ProviderRechargeTransactionType? creditType,
    Enum$ProviderDeductTransactionType? debitType,
    Enum$ProviderExpenseType? expenseType,
    required String currency,
    double? amount,
    String? referenceNumber,
    String? description,
    required GlobalKey<FormState> formKey,
  }) = _AdminAccountingInsertTransactionState;

  factory AdminAccountingInsertTransactionState.initial() =>
      AdminAccountingInsertTransactionState(
        formKey: GlobalKey(),
        currency: Env.defaultCurrency,
      );
}
