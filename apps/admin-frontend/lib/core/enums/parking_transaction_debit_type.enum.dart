import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingTransactionDebitTypeX on Enum$ParkingTransactionDebitType {
  String title(BuildContext context) => switch (this) {
    Enum$ParkingTransactionDebitType.CancelFee => context.tr.cancellationFee,
    Enum$ParkingTransactionDebitType.Correction => context.tr.correction,
    Enum$ParkingTransactionDebitType.Commission => context.tr.commission,
    Enum$ParkingTransactionDebitType.Payout => context.tr.payout,
    Enum$ParkingTransactionDebitType.Refund => context.tr.refunded,
    Enum$ParkingTransactionDebitType.ParkingFee => context.tr.parkingFee,
    Enum$ParkingTransactionDebitType.$unknown => context.tr.unknown,
  };
}
