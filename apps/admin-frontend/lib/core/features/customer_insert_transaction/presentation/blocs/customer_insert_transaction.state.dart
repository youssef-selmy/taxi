part of 'customer_insert_transaction.bloc.dart';

@freezed
sealed class CustomerInsertTransactionState
    with _$CustomerInsertTransactionState {
  const factory CustomerInsertTransactionState({
    required String? customerId,
    Enum$TransactionAction? action,
    Enum$RiderRechargeTransactionType? rechargeType,
    Enum$RiderDeductTransactionType? deductType,
    String? currency,
    double? amount,
    String? referenceNumber,
    String? description,
    required GlobalKey<FormState> formKey,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$customerTransaction> saveState,
  }) = _InsertTransactionState;

  factory CustomerInsertTransactionState.initial({
    required String customerId,
  }) => CustomerInsertTransactionState(
    formKey: GlobalKey(),
    customerId: customerId,
  );

  const CustomerInsertTransactionState._();

  (Enum$TransactionAction, Enum)? get transactionType => action == null
      ? null
      : action == Enum$TransactionAction.Recharge
      ? (action!, rechargeType!)
      : (action!, deductType!);
}
