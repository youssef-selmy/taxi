import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/organisms/invoice_card/invoice_card.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppInvoiceCard)
Widget defaultInvoiceCard(BuildContext context) {
  final currency = context.knobs.currency;
  final canSelectPaymentMethod = context.knobs.boolean(
    label: 'Can Select Payment Method',
    initialValue: true,
  );
  final showPaymentMethod = context.knobs.boolean(
    label: 'Show Payment Method',
    initialValue: true,
  );
  final bool hasSelectedPaymentMethod = context.knobs.boolean(
    label: 'Has Selected Payment Method',
    initialValue: true,
  );
  return SizedBox(
    width: 500,
    child: AppInvoiceCard(
      currency: currency,
      showPaymentMethod: showPaymentMethod,
      onSelectPaymentMethod: canSelectPaymentMethod ? () {} : null,
      selectedPaymentMethod:
          hasSelectedPaymentMethod ? mockSavedPaymentMethod : null,
      items: [
        InvoiceItem(title: "Subtotal", amount: 32.12),
        InvoiceItem(title: "Tax", amount: 2.12),
        InvoiceItem(title: "Shipping", amount: 5.00),
      ],
    ),
  );
}
