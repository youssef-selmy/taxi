import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:better_design_system/molecules/waypoints_view/waypoints_view.dart';
import 'package:collection/collection.dart';
import 'package:generic_map/generic_map.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.mock.dart';
import 'package:admin_frontend/gen/assets.gen.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockPlace1 = Fragment$Place(
  title: 'San Francisco',
  address: 'San Francisco, CA, USA',
  point: mockCoordinateSanFrancisco,
);

final mockPlace2 = Fragment$Place(
  title: 'Oakland',
  address: 'Oakland, CA, USA',
  point: mockCoordinateSanJose,
);

final mockPlace3 = Fragment$Place(
  title: 'Golden Gate Park',
  address: 'Golden Gate Park, CA, USA',
  point: mockCoordinateSanFrancisco,
);

final mockPlace4 = Fragment$Place(
  title: 'San Jose',
  address: 'San Jose, CA, USA',
  point: mockCoordinateSanJose,
);

extension CoordinateFragmentExtensions on Fragment$Coordinate {
  LatLng toLatLngLib() => LatLng(lat, lng);

  Input$PointInput toPointInput() => Input$PointInput(lat: lat, lng: lng);

  Fragment$Place toPlaceFragment({String? title, required String address}) =>
      Fragment$Place(title: title ?? '', address: address, point: this);

  CustomMarker driverMarker(String driverId) => CustomMarker(
    id: driverId,
    position: LatLng(lat, lng),
    widget: Assets.images.carTopView.image(),
    alignment: Alignment.center,
    rotation: heading ?? 0,
    width: 48,
    height: 48,
  );

  // distance in meters
  double distanceFrom(Fragment$Coordinate other) {
    const Distance distance = Distance();
    final double distanceInMeters = distance.as(
      LengthUnit.Meter,
      LatLng(lat, lng),
      LatLng(other.lat, other.lng),
    );
    return distanceInMeters;
  }
}

extension FragmentPlace on Fragment$Place {
  Place toGenericMapPlace() => Place(point.toLatLngLib(), address, title);

  WaypointItem toWaypointItem() => WaypointItem(address: address, title: title);

  LatLng toLatLngLib() => point.toLatLngLib();

  Input$PointInput toPointInput() =>
      Input$PointInput(lat: point.lat, lng: point.lng);
}

extension FragmentPlaceListX on List<Fragment$Place> {
  List<Place> toGenericMapPlaceList() =>
      map((e) => e.toGenericMapPlace()).toList();

  List<Input$PointInput> toPointInputList() =>
      map((e) => e.toPointInput()).toList();

  List<LatLng> toLatLngList() => map((e) => e.toLatLngLib()).toList();

  List<WaypointItem> toWaypointItemList() =>
      map((e) => e.toWaypointItem()).toList();

  List<CustomMarker> get waypointsMarkers {
    final list = toList();
    final result = list.mapIndexed((index, element) {
      if (index == 0 || (first == last && index == list.length - 1)) {
        return AppRodPin.markerPickup(
          id: 'waypoint_$index',
          position: element.point.toLatLngLib(),
        );
      } else if (index == list.length - 1) {
        return AppRodPin.markerDestination(
          id: 'waypoint_$index',
          position: element.point.toLatLngLib(),
        );
      } else {
        return AppRodPin.markerDestination(
          id: 'waypoint_$index',
          position: element.point.toLatLngLib(),
        );
      }
    }).toList();

    return result;
  }
}

extension GenericMapPlace on Place {
  Fragment$Place toFragmentPlace() => Fragment$Place(
    title: title ?? "-",
    address: address,
    point: Fragment$Coordinate(lat: latLng.latitude, lng: latLng.longitude),
  );
}

extension LatLngLibX on LatLng {
  Input$PointInput toPointInput() =>
      Input$PointInput(lat: latitude, lng: longitude);

  Fragment$Coordinate toFragmentCoordinate() =>
      Fragment$Coordinate(lat: latitude, lng: longitude);
}

extension LatLngLibListX on List<LatLng> {
  List<Input$PointInput> toPointInputList() =>
      map((e) => e.toPointInput()).toList();

  List<Fragment$Coordinate> toFragmentCoordinateList() =>
      map((e) => e.toFragmentCoordinate()).toList();
}

extension CoordinateListX on List<Fragment$Coordinate> {
  List<Fragment$Place> toFragmentPlaceList({
    required List<String> titles,
    required List<String> addresses,
  }) {
    return mapIndexed(
      (index, e) => e.toPlaceFragment(
        title: index < titles.length ? titles[index] : null,
        address: addresses[index],
      ),
    ).toList();
  }

  List<CustomMarker> markers({
    required List<String> titles,
    required List<String> addresses,
  }) {
    return toFragmentPlaceList(
      titles: titles,
      addresses: addresses,
    ).waypointsMarkers;
  }

  List<LatLng> toLatLngList() => map((e) => e.toLatLngLib()).toList();

  List<Input$PointInput> toPointInputList() =>
      map((e) => e.toPointInput()).toList();
}

extension Coordinate2DArrayX on List<List<Fragment$Coordinate>> {
  List<List<Input$PointInput>> toPointInputListList() =>
      map((e) => e.toPointInputList()).toList();
}

extension PointInputX on Input$PointInput {
  LatLng toLatLng() => LatLng(lat, lng);

  Fragment$Coordinate toFragmentCoordinate() =>
      Fragment$Coordinate(lat: lat, lng: lng);
}

extension PointInputListX on List<Input$PointInput> {
  List<LatLng> toLatLngList() => map((e) => e.toLatLng()).toList();

  List<Fragment$Coordinate> toFragmentCoordinateList() =>
      map((e) => e.toFragmentCoordinate()).toList();
}

extension WaypointItemX on Fragment$Waypoint {
  WaypointItem toWaypoint(BuildContext context) => WaypointItem(
    address: address,
    title: role == Enum$WaypointRole.Pickup
        ? context.tr.pickup
        : role == Enum$WaypointRole.Dropoff
        ? context.tr.dropOff
        : context.tr.stopPoint,
  );
}

extension WaypointItemsX on List<Fragment$Waypoint> {
  List<LatLng> toLatLngs() => map((e) => e.location.toLatLngLib()).toList();

  List<WaypointItem> toWaypoints(BuildContext context) =>
      map((e) => e.toWaypoint(context)).toList();

  AppWaypointsView toWaypointsView(BuildContext context) {
    return AppWaypointsView(waypoints: toWaypoints(context));
  }

  List<CustomMarker> get markers => mapIndexed((index, e) {
    if (e.role == Enum$WaypointRole.Pickup) {
      return AppRodPin.markerPickup(
        id: "${e.role}_$index",
        position: e.location.toLatLngLib(),
      );
    }
    return AppRodPin.markerDestination(
      id: "${e.role}_$index",
      position: e.location.toLatLngLib(),
    );
  }).toList();
}
