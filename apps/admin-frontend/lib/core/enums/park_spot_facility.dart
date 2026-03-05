import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension EnumFacilitiesX on Enum$ParkSpotFacility {
  IconData get icon {
    switch (this) {
      case Enum$ParkSpotFacility.CCTV:
        return BetterIcons.cctvCameraFilled;
      case Enum$ParkSpotFacility.COVERED:
        return BetterIcons.checkmarkCircle02Filled;
      case Enum$ParkSpotFacility.CAR_WASH:
        return BetterIcons.checkmarkCircle02Filled;
      default:
        return BetterIcons.checkmarkCircle02Filled;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case Enum$ParkSpotFacility.CCTV:
        return context.tr.cctv;
      case Enum$ParkSpotFacility.COVERED:
        return context.tr.covered;
      case Enum$ParkSpotFacility.CAR_WASH:
        return context.tr.carWash;
      case Enum$ParkSpotFacility.ELECTRIC_CHARGING:
        return context.tr.electricCharging;
      case Enum$ParkSpotFacility.GUARDED:
        return context.tr.guarded;
      case Enum$ParkSpotFacility.TOILET:
        return context.tr.toilet;
      case Enum$ParkSpotFacility.$unknown:
        return context.tr.unknown;
    }
  }
}
