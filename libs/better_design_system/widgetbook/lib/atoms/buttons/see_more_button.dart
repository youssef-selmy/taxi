import 'package:better_design_system/atoms/buttons/see_more_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSeeMoreButton)
Widget defaultAppSeeMoreButton(BuildContext context) {
  return AppSeeMoreButton(onPressed: () {});
}
