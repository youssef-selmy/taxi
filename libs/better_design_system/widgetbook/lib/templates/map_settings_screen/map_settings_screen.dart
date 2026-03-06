import 'package:better_design_system/templates/map_settings_screen/map_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:generic_map/generic_map.dart';

@UseCase(name: 'Default', type: AppMapSettingsScreen)
Widget defaultMapSettingsScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: AppMapSettingsScreen(
      onMapProviderChanged: (provider) {
        // Handle map provider change
      },
      mapProvider: context.knobs.object.dropdown(
        label: 'Map Provider',
        description: 'Select the map provider',
        options: MapProviderEnum.values,
        initialOption: MapProviderEnum.googleMaps,
      ),
    ),
  );
}
