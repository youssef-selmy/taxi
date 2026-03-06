import 'package:better_design_system/organisms/geofence_form_field/geofence_form_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppGeofenceFormField)
Widget defaultGeofenceFormField(BuildContext context) {
  return SizedBox(
    width: 500,
    height: 400,
    child: AppGeofenceFormField(onChanged: (_) {}),
  );
}
