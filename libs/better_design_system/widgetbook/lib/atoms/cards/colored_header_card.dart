import 'package:better_design_system/atoms/cards/colored_header_card.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppColoredHeaderCard)
Widget defaultColoredHeaderCard(BuildContext context) {
  return AppColoredHeaderCard(
    header: Text('Header'),
    content: Padding(padding: const EdgeInsets.all(64), child: Text('Content')),
    onTap: () {},
  );
}
