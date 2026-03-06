// ignore_for_file: depend_on_referenced_packages

import 'package:api_response/api_response.dart';
import 'package:better_design_system/organisms/search_location_field/search_location_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:generic_map/generic_map.dart';
import 'package:latlong2/latlong.dart';

@UseCase(name: 'Default', type: AppSearchLocationField)
Widget defaultSearchLocationField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppSearchLocationField(
      onSearch: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return ApiResponseLoaded([
          Place(LatLng(0, 0), "Address 1 for $query", "Title"),
          Place(LatLng(0, 0), "Address 2 for $query", "Title"),
          Place(LatLng(0, 0), "Address 3 for $query", "Title"),
        ]);
      },
      onPlaceSelected: (_) {},
    ),
  );
}
