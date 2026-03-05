part of 'shop_insert_transaction.bloc.dart';

@freezed
sealed class ShopInsertTransactionState with _$ShopInsertTransactionState {
  const factory ShopInsertTransactionState({
    required String? shopId,
    Enum$TransactionType? type,
    Enum$ShopTransactionCreditType? rechargeType,
    Enum$ShopTransactionDebitType? deductType,
    String? currency,
    double? amount,
    String? referenceNumber,
    String? description,
    required GlobalKey<FormState> formKey,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopTransaction> saveState,
  }) = _ShopInsertTransactionState;

  factory ShopInsertTransactionState.initial({required String shopId}) =>
      ShopInsertTransactionState(formKey: GlobalKey(), shopId: shopId);

  const ShopInsertTransactionState._();

  (Enum$TransactionType, Enum)? get transactionType => type == null
      ? null
      : type == Enum$TransactionType.Credit
      ? (type!, rechargeType!)
      : (type!, deductType!);
}
