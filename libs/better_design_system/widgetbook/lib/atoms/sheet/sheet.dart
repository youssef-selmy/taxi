import 'package:better_design_system/atoms/sheet/sheet.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSheet)
Widget defaultSheet(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppSheet(
      showHandle: context.knobs.boolean(
        label: 'Show Handle',
        initialValue: true,
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Footer Content"),
      ),
      child: Padding(padding: const EdgeInsets.all(50), child: Text("Content")),
    ),
  );
}
