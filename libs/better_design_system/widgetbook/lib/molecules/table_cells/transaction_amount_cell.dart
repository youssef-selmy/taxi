import 'package:better_design_system/molecules/table_cells/transaction_amount_cell.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppTransactionAmountCell)
Widget defaultTransactionAmountCell(BuildContext context) {
  return AppTransactionAmountCell(
    amount: context.knobs.double.slider(
      label: 'Amount',
      min: -1000,
      max: 1000,
      initialValue: 10,
    ),
    currency: context.knobs.currency,
  );
}

@UseCase(name: 'Negative', type: AppTransactionAmountCell)
Widget negativeTransactionAmountCell(BuildContext context) {
  return AppTransactionAmountCell(
    amount: -100,
    currency: context.knobs.currency,
  );
}

@UseCase(name: 'Positive', type: AppTransactionAmountCell)
Widget incomeTransactionAmountCell(BuildContext context) {
  return AppTransactionAmountCell(
    amount: 100,
    currency: context.knobs.currency,
    isIncome: true,
  );
}
