import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingTransactionCreditTypeX on Enum$ParkingTransactionCreditType {
  String title(BuildContext context) => switch (this) {
    Enum$ParkingTransactionCreditType.BankTransfer => context.tr.bankTransfer,
    Enum$ParkingTransactionCreditType.Correction => context.tr.correction,
    Enum$ParkingTransactionCreditType.GiftCardTopUp => context.tr.giftCard,
    Enum$ParkingTransactionCreditType.ParkingRentalIncome =>
      context.tr.parkingRentalIncome,
    Enum$ParkingTransactionCreditType.WalletTopUp => context.tr.onlinePayment,
    Enum$ParkingTransactionCreditType.$unknown => context.tr.unknown,
  };
}
