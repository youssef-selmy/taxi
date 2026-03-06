import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppClickableCard)
Widget defaultClickableCard(BuildContext context) {
  return AppClickableCard(
    onTap: () {},
    type: context.knobs.object.dropdown(
      label: 'Type',
      options: ClickableCardType.values,
      initialOption: ClickableCardType.outline,
      labelBuilder: (value) => value.name,
    ),
    child: SizedBox(height: 300, width: 400),
  );
}
