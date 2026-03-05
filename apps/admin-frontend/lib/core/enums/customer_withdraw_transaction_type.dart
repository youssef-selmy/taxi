import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CustomerWithdrawTransactionTypeX on Enum$RiderDeductTransactionType {
  String name(BuildContext context) {
    switch (this) {
      case Enum$RiderDeductTransactionType.OrderFee:
        return context.tr.orderFee;
      case Enum$RiderDeductTransactionType.ParkingFee:
        return context.tr.parkingFee;
      case Enum$RiderDeductTransactionType.CancellationFee:
        return context.tr.cancellationFee;
      case Enum$RiderDeductTransactionType.Withdraw:
        return context.tr.withdraw;
      case Enum$RiderDeductTransactionType.Correction:
        return context.tr.correction;
      case Enum$RiderDeductTransactionType.$unknown:
        return context.tr.unknown;
    }
  }
}
