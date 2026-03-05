import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingVehicleTypeEnumX on Enum$ParkSpotVehicleType {
  String text(BuildContext context) {
    switch (this) {
      case Enum$ParkSpotVehicleType.Bike:
        return context.tr.bike;
      case Enum$ParkSpotVehicleType.Car:
        return context.tr.car;
      case Enum$ParkSpotVehicleType.Truck:
        return context.tr.truck;
      default:
        return context.tr.unknown;
    }
  }

  IconData icon() {
    switch (this) {
      case Enum$ParkSpotVehicleType.Bike:
        return BetterIcons.bicycle01Filled;
      case Enum$ParkSpotVehicleType.Car:
        return BetterIcons.car05Filled;
      case Enum$ParkSpotVehicleType.Truck:
        return BetterIcons.truckFilled;
      default:
        return BetterIcons.car05Filled;
    }
  }
}
