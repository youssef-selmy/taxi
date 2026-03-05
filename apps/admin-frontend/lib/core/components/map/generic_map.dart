import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_map/generic_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/settings.bloc.dart';
import 'package:admin_frontend/core/components/map/repositories/geo_repository.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_design_system/organisms/generic_map/generic_map.dart'
    as better;

export 'package:generic_map/generic_map.dart';
export 'package:better_design_system/organisms/generic_map/generic_map.dart'
    show SearchBarOptions;

class AppGenericMap extends StatefulWidget {
  final MapViewMode mode;
  final CenterMarker Function(
    BuildContext context,
    GlobalKey key,
    String? address,
  )?
  centerMarkerBuilder;
  final bool interactive;
  final Function(MapViewController)? onControllerReady;
  final Function(MapMovedEvent)? onMapMoved;
  final Place? initialLocation;
  final List<PolyLineLayer> polylines;
  final List<CustomMarker> markers;
  final List<CircleMarker> circleMarkers;
  final EdgeInsets padding;
  final bool hasSearchBar;
  final Function(Place)? onPlaceSelected;
  final bool isPolylineDrawModeEnabled;
  final PolyEditor? polyEditor;
  final Function(List<LatLng>)? onPolylineDrawn;
  final bool enableAddressResolve;

  const AppGenericMap({
    super.key,
    this.initialLocation,
    this.mode = MapViewMode.static,
    this.onControllerReady,
    this.polylines = const [],
    this.onMapMoved,
    this.interactive = false,
    this.padding = EdgeInsets.zero,
    this.markers = const <CustomMarker>[],
    this.centerMarkerBuilder,
    this.circleMarkers = const [],
    this.hasSearchBar = false,
    this.onPlaceSelected,
    this.isPolylineDrawModeEnabled = false,
    this.polyEditor,
    this.enableAddressResolve = false,
    this.onPolylineDrawn,
  });

  @override
  State<AppGenericMap> createState() => _AppGenericMapState();
}

class _AppGenericMapState extends State<AppGenericMap> {
  late MapViewController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.mapProvider != current.mapProvider,
      builder: (context, state) {
        return better.AppGenericMap(
          platformMapProviderSettings: PlatformMapProviderSettings(
            defaultProvider: state.mapProvider,
          ),
          mapLibreOptions: Env.mapLibreOptions(context.isDark),
          mapboxOptions: Env.mapboxOptions(context.isDark),
          mapboxSdkOptions: Env.mapboxSdkOptions(context.isDark),
          enableAddressResolve: widget.enableAddressResolve,
          searchbarOptions: widget.hasSearchBar
              ? better.SearchBarOptions(
                  onSearch: (query) async {
                    final center = await _controller.getCenter();
                    final places = await locator<GeoRepository>().getPlaces(
                      query: query,
                      location: center.toPointInput(),
                      language: state.locale,
                      mapProvider: MapProviderEnum.googleMaps,
                    );
                    return places.mapData(
                      (place) => place.toGenericMapPlaceList(),
                    );
                  },
                  onPlaceSelected: (event) {
                    widget.onPlaceSelected?.call(event);
                    _controller.moveCamera(event.latLng, null);
                  },
                )
              : null,
          openStreetMapOptions: OpenStreetMapsOptions(
            userAgentPackageName: 'com.bettersuite.admin',
          ),
          useCachedTiles: kIsWeb ? false : true,
          mode: widget.mode,
          isPolylineDrawEnabled: widget.isPolylineDrawModeEnabled,
          polyEditor: widget.polyEditor,
          onPolylineDrawn: widget.onPolylineDrawn,
          centerMarkerBuilder: widget.centerMarkerBuilder,
          addressResolver: (provider, latlng) async {
            // print('Resolving address for $latlng using $provider');
            final settingsState = locator<SettingsCubit>().state;
            final result = await locator<GeoRepository>().getAddressForLocation(
              latLng: latlng,
              language: settingsState.locale,
              mapProvider: settingsState.mapProvider,
            );
            return switch (result) {
              ApiResponseLoaded(:final data) => data.toGenericMapPlace(),
              _ => Fragment$Place(
                title: "",
                point: Fragment$Coordinate(lat: 0, lng: 0),
                address: "",
              ).toGenericMapPlace(),
            };
          },
          interactive: widget.interactive,
          onControllerReady: (controller) {
            _controller = controller;
            widget.onControllerReady?.call(controller);
          },
          onMapMoved: (event) {
            return widget.onMapMoved?.call(event);
          },
          initialLocation: widget.initialLocation ?? Env.defaultLocation,
          polylines: widget.polylines,
          markers: widget.markers,
          circleMarkers: widget.circleMarkers,
          padding: widget.padding,
        );
      },
    );
  }
}
