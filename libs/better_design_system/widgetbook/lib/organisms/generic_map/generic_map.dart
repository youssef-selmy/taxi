import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:better_design_system/organisms/generic_map/generic_map.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/interfaces/map_provider_enum.dart';
import 'package:generic_map/interfaces/map_view_mode.dart';
import 'package:generic_map/interfaces/place.dart';
import 'package:generic_map/platform_map_provider_settings.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppGenericMap)
Widget defaultGenericMap(BuildContext context) {
  return SizedBox(
    height: 700,
    child: AppGenericMap(
      mode: MapViewMode.static,
      platformMapProviderSettings: PlatformMapProviderSettings(
        defaultProvider: MapProviderEnum.mapLibre,
        desktopProvider: MapProviderEnum.openStreetMaps,
      ),
      interactive: true,
      initialLocation: Place(LatLng(37.7749, -122.4194), 'Test Location', ''),
      initialZoom: 13.0,
      searchbarOptions: SearchBarOptions(
        isExpanded: context.knobs.boolean(label: 'Expanded'),
        alignment: context.knobs.object.dropdown(
          label: 'Alignment',
          options: SearchBarAlignment.values,
          labelBuilder: (value) => value.name,
        ),
        onSearch: (query) async {
          return ApiResponse.loaded([
            Place(LatLng(37.7799, -122.4194), 'Result 1', ''),
            Place(LatLng(37.7699, -122.4294), 'Result 2', ''),
          ]);
        },
        onPlaceSelected: (place) {
          debugPrint('Selected place: ${place.address}');
        },
      ),
    ),
  );
}
