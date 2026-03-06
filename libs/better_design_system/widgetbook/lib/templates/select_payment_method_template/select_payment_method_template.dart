import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/templates/select_payment_method_template/select_payment_method_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSelectPaymentMethodTemplate)
Widget defaultSelectPaymentMethodTemplate(BuildContext context) {
  return SizedBox(
    width: 600,
    child: AppSelectPaymentMethodTemplate(
      onAddPaymentMethod: () {},
      paymentMethods: [
        PaymentMethodEntity(
          id: "1",
          title: "Visa card ending with 1234",
          type: PaymentMethodType.savedCard,
          card: PaymentMethodCard.visa,
        ),
      ],
      onPaymentMethodSelected: (value) {},
    ),
  );
}
