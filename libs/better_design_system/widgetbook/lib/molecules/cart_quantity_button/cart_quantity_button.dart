import 'package:better_design_system/molecules/cart_quantity_button/cart_quantity_button.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppCartQuantityButton)
Widget defaultCartQuantityButton(BuildContext context) {
  return SizedBox(
    width: 600,
    child: AppCartQuantityButton(
      price: 50,
      color: context.knobs.semanticColor,
      currency: context.knobs.currency,
      isUnavailable: context.knobs.boolean(
        label: 'Is Unavailable',
        initialValue: false,
      ),
      quantity: context.knobs.int.slider(
        label: 'Quantity',
        initialValue: 0,
        min: 0,
      ),
      onGoToCartTap: () {},
      onIncreaseTap: () {},
      onDecreaseTap: () {},
    ),
  );
}
