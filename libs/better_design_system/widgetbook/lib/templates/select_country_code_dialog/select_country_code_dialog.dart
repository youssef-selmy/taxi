import 'package:better_design_system/templates/select_country_code_dialog_template/select_country_code_dialog.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSelectCountryCodeDialog)
Widget defaultSelectCountryCodeDialog(BuildContext context) {
  return AppSelectCountryCodeDialog(initialCountryCode: 'US');
}
