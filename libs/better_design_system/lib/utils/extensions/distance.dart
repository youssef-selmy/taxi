part of 'extensions.dart';

extension LatLngDistanceX on LatLng {
  String distanceTo(LatLng other, BuildContext context) {
    const Distance distance = Distance();
    // if (Constants.defaultMeasurementSystem == MeasurementSystem.metric) {
    final distanceInMeters = distance.as(LengthUnit.Meter, this, other);
    if (distanceInMeters < 1000) {
      return context.strings.distanceInMeters(distanceInMeters);
    } else {
      return context.strings.distanceInKilometers(distanceInMeters / 1000);
    }
    // } else {
    //   final distanceInMiles = distance.as(LengthUnit.Mile, this, other);
    //   return context.strings.distanceInMiles(distanceInMiles);
    // }
  }

  int distanceWith(LatLng latLng) {
    const Distance distance = Distance();
    return distance.as(LengthUnit.Meter, this, latLng).toInt();
  }
}

extension IntDistanceX on int {
  @Deprecated('Use context.formatDistance instead')
  String toFormattedDistance(BuildContext context) {
    // if (Constants.defaultMeasurementSystem == MeasurementSystem.metric) {
    if (this < 1000) {
      return context.strings.distanceInMeters(this);
    } else {
      return context.strings.distanceInKilometers(this / 1000);
    }
    // } else {
    //   if (this < 1609) {
    //     return context.strings.distanceInFeets(this);
    //   } else {
    //     return context.strings.distanceInMiles(this / 1609);
    //   }
    // }
  }
}
