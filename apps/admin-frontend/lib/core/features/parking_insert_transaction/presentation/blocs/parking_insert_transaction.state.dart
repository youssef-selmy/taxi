part of 'parking_insert_transaction.bloc.dart';

@freezed
sealed class ParkingInsertTransactionState
    with _$ParkingInsertTransactionState {
  const factory ParkingInsertTransactionState({
    required String? parkingId,
    Enum$TransactionType? type,
    Enum$ParkingTransactionCreditType? rechargeType,
    Enum$ParkingTransactionDebitType? deductType,
    String? currency,
    double? amount,
    String? referenceNumber,
    String? description,
    required GlobalKey<FormState> formKey,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkingTransaction> saveState,
  }) = _ParkingInsertTransactionState;

  factory ParkingInsertTransactionState.initial({required String parkingId}) =>
      ParkingInsertTransactionState(formKey: GlobalKey(), parkingId: parkingId);

  const ParkingInsertTransactionState._();

  (Enum$TransactionType, Enum)? get transactionType => type == null
      ? null
      : type == Enum$TransactionType.Credit
      ? (type!, rechargeType!)
      : (type!, deductType!);
}
