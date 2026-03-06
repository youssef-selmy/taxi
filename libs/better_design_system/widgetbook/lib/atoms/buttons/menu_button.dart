import 'package:better_design_system/atoms/buttons/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppMenuButton)
Widget defaultAppMenuButton(BuildContext context) {
  return AppMenuButton(onPressed: () {});
}
