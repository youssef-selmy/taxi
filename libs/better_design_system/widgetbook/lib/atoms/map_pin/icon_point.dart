import 'package:better_design_system/atoms/map_pin/icon_point.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppIconPoint)
Widget defaultIconPoint(BuildContext context) {
  return AppIconPoint(iconData: context.knobs.icon);
}
