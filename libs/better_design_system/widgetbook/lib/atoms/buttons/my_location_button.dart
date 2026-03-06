import 'package:better_design_system/atoms/buttons/my_location_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppMyLocationButton)
Widget defaultMyLocationButton(BuildContext context) {
  return AppMyLocationButton(onPressed: () {});
}
