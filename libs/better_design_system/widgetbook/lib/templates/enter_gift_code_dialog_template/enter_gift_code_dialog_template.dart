import 'package:better_design_system/templates/enter_gift_code_dialog_template/enter_gift_code_dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppEnterGiftCodeDialogTemplate)
Widget defaultEnterGiftCodeDialogTemplate(BuildContext context) {
  return SizedBox(
    width: 600,
    child: AppEnterGiftCodeDialogTemplate(
      validateCode: (value) async {
        return "Error";
      },
    ),
  );
}
