import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ServiceOptionIcon on Enum$ServiceOptionIcon {
  String name(BuildContext context) {
    switch (this) {
      case Enum$ServiceOptionIcon.Pet:
        return context.tr.pet;
      case Enum$ServiceOptionIcon.TwoWay:
        return context.tr.twoWay;
      case Enum$ServiceOptionIcon.Luggage:
        return context.tr.luggage;

      case Enum$ServiceOptionIcon.PackageDelivery:
        return context.tr.packageDelivery;
      case Enum$ServiceOptionIcon.Shopping:
        return context.tr.shopping;
      case Enum$ServiceOptionIcon.Custom1:
        return context.tr.customNumbered(1);
      case Enum$ServiceOptionIcon.Custom2:
        return context.tr.customNumbered(2);
      case Enum$ServiceOptionIcon.Custom3:
        return context.tr.customNumbered(3);
      case Enum$ServiceOptionIcon.Custom4:
        return context.tr.customNumbered(4);
      case Enum$ServiceOptionIcon.Custom5:
        return context.tr.customNumbered(5);
      case Enum$ServiceOptionIcon.$unknown:
        return context.tr.unknown;
    }
  }

  IconData get icon {
    switch (this) {
      case Enum$ServiceOptionIcon.Pet:
        return BetterIcons.helpCircleOutline;
      case Enum$ServiceOptionIcon.TwoWay:
        return BetterIcons.arrowReloadHorizontalFilled;
      default:
        return BetterIcons.alert02Filled;
    }
  }
}
