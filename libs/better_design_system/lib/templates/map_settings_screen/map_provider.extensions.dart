import 'package:better_assets/assets.dart';
import 'package:generic_map/generic_map.dart';

extension MapProviderX on MapProviderEnum {
  String get title => switch (this) {
    MapProviderEnum.googleMaps => "Google Maps",
    MapProviderEnum.openStreetMaps => "Open Street Maps",
    MapProviderEnum.mapBox => "MapBox",
    MapProviderEnum.mapBoxSDK => "MapBox SDK",
    MapProviderEnum.mapLibre => "MapLibre",
  };

  List<String> get positivePoints => switch (this) {
    MapProviderEnum.googleMaps => ["Attractive design"],
    MapProviderEnum.openStreetMaps => ["Free", "Good performance", "Native"],
    MapProviderEnum.mapBox => [
      "Attractive design",
      "Good performance",
      "Native",
    ],
    MapProviderEnum.mapBoxSDK => ["Attractive design", "Good performance"],
    MapProviderEnum.mapLibre => [
      "Free",
      "Attractive design",
      "Good performance",
    ],
  };

  List<String> get negativePoints => switch (this) {
    MapProviderEnum.googleMaps => [
      "No support for web and desktop",
      "Some known bugs and performance issues",
    ],
    MapProviderEnum.openStreetMaps => ["Less Attractive UI"],
    MapProviderEnum.mapBox => ["Expensive"],
    MapProviderEnum.mapBoxSDK => ["Expensive"],
    MapProviderEnum.mapLibre => ["Expensive"],
  };

  AssetGenImage get image => switch (this) {
    MapProviderEnum.googleMaps => Assets.images.mapPreviews.googlemap,
    MapProviderEnum.openStreetMaps => Assets.images.mapPreviews.openstreet,
    MapProviderEnum.mapBox => Assets.images.mapPreviews.mapbox,
    MapProviderEnum.mapBoxSDK => Assets.images.mapPreviews.mapboxSdk,
    MapProviderEnum.mapLibre => Assets.images.mapPreviews.maplibre,
  };
}
