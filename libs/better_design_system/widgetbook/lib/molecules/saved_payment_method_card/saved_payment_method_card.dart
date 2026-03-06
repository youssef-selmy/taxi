import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/molecules/saved_payment_method_card/saved_payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSavedPaymentMethodCard)
Widget defaultSavedPaymentMethodCard(BuildContext context) {
  return AppSavedPaymentMethodCard(
    title: '***** **** **** 1234',
    cardType: PaymentMethodCard.mastercard,
    expirationDate: '12/25',
    holderName: 'John Doe',
    isLoading: context.knobs.boolean(
      label: 'Is Loading',
      description: 'Indicates if the card is loading',
      initialValue: false,
    ),
  );
}
