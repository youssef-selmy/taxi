import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension RiderRechargeTransactionTypeX on Enum$RiderRechargeTransactionType {
  String name(BuildContext context) {
    switch (this) {
      case Enum$RiderRechargeTransactionType.BankTransfer:
        return context.tr.bankTransfer;
      case Enum$RiderRechargeTransactionType.Gift:
        return context.tr.gift;
      case Enum$RiderRechargeTransactionType.Correction:
        return context.tr.correction;
      case Enum$RiderRechargeTransactionType.InAppPayment:
        return context.tr.inAppPayment;
      case Enum$RiderRechargeTransactionType.$unknown:
        return '';
    }
  }
}
