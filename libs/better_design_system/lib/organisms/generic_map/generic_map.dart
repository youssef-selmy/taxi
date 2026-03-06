import 'package:better_design_system/organisms/generic_map/search_bar_options.dart';
import 'package:better_design_system/organisms/search_location_field/search_location_field.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/generic_map.dart';
import 'package:generic_map/interfaces/heat_map_config.dart';
import 'package:latlong2/latlong.dart';
export 'search_bar_options.dart';

enum SearchBarAlignment {
  topLeft,
  topCenter,
  topRight;

  Alignment get alignment => switch (this) {
    SearchBarAlignment.topLeft => Alignment.topLeft,
    SearchBarAlignment.topCenter => Alignment.topCenter,
    SearchBarAlignment.topRight => Alignment.topRight,
  };
}

typedef BetterGenericMap = AppGenericMap;

class AppGenericMap extends StatelessWidget {
  final MapViewMode mode;
  final CenterMarker Function(
    BuildContext context,
    GlobalKey key,
    String? address,
  )?
  centerMarkerBuilder;
  final AddressResolver? addressResolver;
  final PlatformMapProviderSettings platformMapProviderSettings;
  final MapboxSdkOptions? mapboxSdkOptions;
  final MapboxOptions? mapboxOptions;
  final MapLibreOptions? mapLibreOptions;
  final OpenStreetMapsOptions? openStreetMapOptions;
  final GoogleMapsOptions? googleMapOptions;
  final bool interactive;
  final Function(MapViewController)? onControllerReady;
  final Function(MapMovedEvent)? onMapMoved;
  final Place initialLocation;
  final double initialZoom;
  final List<PolyLineLayer> polylines;
  final List<CustomMarker> markers;
  final List<CircleMarker> circleMarkers;
  final bool showMyLocation;
  final List<HeatmapConfig> heatmapConfig;
  final EdgeInsets padding;
  final EdgeInsets actionsPadding;
  final bool useCachedTiles;
  final bool isPolylineDrawEnabled;
  final PolyEditor? polyEditor;
  final Function(List<LatLng>)? onPolylineDrawn;
  final SearchBarOptions? searchbarOptions;
  final bool enableAddressResolve;

  const AppGenericMap({
    super.key,
    this.platformMapProviderSettings = const PlatformMapProviderSettings(
      defaultProvider: MapProviderEnum.openStreetMaps,
    ),
    this.initialLocation = const Place(
      LatLng(37.7858, -122.4064),
      'San Francisco, CA',
      'San Francisco',
    ),
    this.initialZoom = 14,
    this.mode = MapViewMode.static,
    this.onControllerReady,
    this.polylines = const [],
    this.onMapMoved,
    this.useCachedTiles = false,
    this.interactive = false,
    this.padding = EdgeInsets.zero,
    this.actionsPadding = EdgeInsets.zero,
    this.markers = const <CustomMarker>[],
    this.centerMarkerBuilder,
    this.addressResolver,
    this.circleMarkers = const [],
    this.isPolylineDrawEnabled = false,
    this.polyEditor,
    this.onPolylineDrawn,
    this.mapboxSdkOptions,
    this.mapboxOptions,
    this.mapLibreOptions,
    this.openStreetMapOptions,
    this.googleMapOptions,
    this.heatmapConfig = const [],
    this.showMyLocation = true,
    this.searchbarOptions,
    this.enableAddressResolve = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: searchbarOptions != null
          ? searchbarOptions!.alignment.alignment
          : AlignmentDirectional.topStart,
      children: [
        Positioned.fill(
          child: GenericMap(
            mode: mode,
            centerMarkerBuilder: centerMarkerBuilder,
            addressResolver: addressResolver,
            platformMapProviderSettings: platformMapProviderSettings,
            mapboxSdkOptions: mapboxSdkOptions,
            mapboxOptions: mapboxOptions,
            mapLibreOptions: mapLibreOptions,
            openStreetMapOptions: openStreetMapOptions,
            googleMapOptions: googleMapOptions,
            interactive: interactive,
            onControllerReady: onControllerReady,
            onMapMoved: onMapMoved,
            initialLocation: initialLocation,
            initialZoom: initialZoom,
            polylines: polylines,
            markers: markers,
            circleMarkers: circleMarkers,
            showMyLocation: showMyLocation,
            heatmapConfig: heatmapConfig,
            padding: padding,
            enableAddressResolve: enableAddressResolve,
            mapMoveDebounce: const Duration(milliseconds: 250),
            addressResolveDebounce: const Duration(milliseconds: 500),
            actionsPadding: actionsPadding,
            useCachedTiles: useCachedTiles,
            isPolylineDrawEnabled: isPolylineDrawEnabled,
            polyEditor: polyEditor,
            onPolylineDrawn: onPolylineDrawn,
          ),
        ),

        if (searchbarOptions != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: searchbarOptions!.isExpanded ? null : 361,
              child: AppSearchLocationField(
                onSearch: searchbarOptions!.onSearch,
                onPlaceSelected: searchbarOptions!.onPlaceSelected,
              ),
            ),
          ),
      ],
    );
  }
}
