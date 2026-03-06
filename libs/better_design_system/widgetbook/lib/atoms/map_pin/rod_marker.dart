import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:generic_map/generic_map.dart';

@UseCase(name: 'Default', type: AppRodMarker)
Widget defaultRodPin(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    spacing: 16,
    children: [
      AppRodMarker(
        title: "New York",
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
      AppRodMarker(
        title: "New York",
        icon: BetterIcons.hamburger01Filled,
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
      AppRodMarker(
        title: "New York",
        isIconProminent: true,
        icon: BetterIcons.hamburger01Filled,
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
      AppRodMarker(
        title: "Los Angeles",
        subtitle: "50 km",
        imageUrl: ImageFaker().person.four,
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
    ],
  );
}

@UseCase(name: 'With Map', type: AppRodMarker)
Widget defaultRodMarker(BuildContext context) {
  return SizedBox(
    width: 500,
    height: 500,
    child: GenericMap(
      initialLocation: Place(LatLng(40.7128, -74.0060), "San Francisco", ""),
      interactive: true,
      markers: [
        AppRodMarker.marker(
          id: "nyc",
          position: LatLng(40.7128, -74.0060),
          title: "New York",
          iconData: BetterIcons.hamburger01Filled,
          isIconProminent: true,
        ),
        AppRodMarker.marker(
          id: "la",
          position: LatLng(34.0522, -118.2437),
          title: "Los Angeles",
        ),
      ],
    ),
  );
}
