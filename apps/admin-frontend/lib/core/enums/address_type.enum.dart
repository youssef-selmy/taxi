import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

extension AddressTypeGQLX on Enum$RiderAddressType {
  IconData get icon => switch (this) {
    Enum$RiderAddressType.Home => BetterIcons.home01Filled,
    Enum$RiderAddressType.Work => BetterIcons.city02Filled,
    Enum$RiderAddressType.Partner => BetterIcons.favouriteFilled,
    Enum$RiderAddressType.Gym => BetterIcons.dumbbell02Filled,
    Enum$RiderAddressType.Parent => BetterIcons.userMultipleFilled,
    Enum$RiderAddressType.Cafe => BetterIcons.coffee02Filled,
    Enum$RiderAddressType.Park => BetterIcons.tree02Filled,
    Enum$RiderAddressType.Other => BetterIcons.alert02Filled,
    Enum$RiderAddressType.$unknown => BetterIcons.alert02Filled,
  };

  String name(BuildContext context) => switch (this) {
    Enum$RiderAddressType.Home => context.tr.addressHome,
    Enum$RiderAddressType.Work => context.tr.addressWork,
    Enum$RiderAddressType.Partner => context.tr.addressPartner,
    Enum$RiderAddressType.Gym => context.tr.addressGym,
    Enum$RiderAddressType.Parent => context.tr.addressParent,
    Enum$RiderAddressType.Cafe => context.tr.addressCafe,
    Enum$RiderAddressType.Park => context.tr.addressPark,
    Enum$RiderAddressType.Other => context.tr.addressOther,
    Enum$RiderAddressType.$unknown => context.tr.unknown,
  };
}
