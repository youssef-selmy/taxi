import 'package:better_design_system/molecules/quantity_button/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: QuantityButton)
Widget defaultQuantityButton(BuildContext context) {
  return QuantityButton(
    quantity: 3,
    maxQuantity: 10,
    onQuantityChanged: (value) {},
  );
}
