part of 'driver_insert_transaction.bloc.dart';

@freezed
sealed class DriverInsertTransactionState with _$DriverInsertTransactionState {
  const factory DriverInsertTransactionState({
    required String? driverId,
    Enum$TransactionAction? action,
    Enum$DriverRechargeTransactionType? rechargeType,
    Enum$DriverDeductTransactionType? deductType,
    String? currency,
    double? amount,
    String? referenceNumber,
    String? description,
    required GlobalKey<FormState> formKey,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$driverTransaction> saveState,
  }) = _DriverInsertTransactionState;

  factory DriverInsertTransactionState.initial({required String driverId}) =>
      DriverInsertTransactionState(formKey: GlobalKey(), driverId: driverId);

  const DriverInsertTransactionState._();

  (Enum$TransactionAction, Enum)? get transactionType => action == null
      ? null
      : action == Enum$TransactionAction.Recharge
      ? (action!, rechargeType!)
      : (action!, deductType!);
}
