import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDivider)
Widget defaultDivider(BuildContext context) {
  return SizedBox(
    width: 500,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 32,
      children: [
        AppDivider(),
        AppDivider(text: 'OR', alignment: DividerTextAlignment.center),
        AppDivider(text: 'OR', alignment: DividerTextAlignment.right),
        AppDivider(text: 'OR', alignment: DividerTextAlignment.left),
        AppDivider(isDashed: true),
        AppDivider(
          text: 'OR',
          isDashed: true,
          alignment: DividerTextAlignment.center,
        ),
        AppDivider(
          text: 'OR',
          isDashed: true,
          alignment: DividerTextAlignment.right,
        ),
        AppDivider(
          text: 'OR',
          isDashed: true,
          alignment: DividerTextAlignment.left,
        ),
      ],
    ),
  );
}
