import 'package:flutter/cupertino.dart';

import 'package:generic_map/generic_map.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension AddressFragmentProdX on Fragment$Address {
  IconData get icon => switch (type) {
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

  Place toGenericMapPlace() =>
      Place(location.toLatLngLib(), title, details ?? "-");

  Fragment$Place toFragmentPlace() =>
      Fragment$Place(title: title, address: details ?? "-", point: location);

  Widget tableView(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: context.colors.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: context.textTheme.labelMedium),
              Text(
                details ?? "-",
                style: context.textTheme.labelMedium?.variant(context),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension AddressTypeX on Enum$RiderAddressType {
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      Enum$RiderAddressType.Home => context.tr.addressHome,
      Enum$RiderAddressType.Work => context.tr.addressWork,
      Enum$RiderAddressType.Partner => context.tr.addressPartner,
      Enum$RiderAddressType.Gym => context.tr.addressGym,
      Enum$RiderAddressType.Parent => context.tr.addressParent,
      Enum$RiderAddressType.Cafe => context.tr.addressCafe,
      Enum$RiderAddressType.Park => context.tr.addressPark,
      Enum$RiderAddressType.Other => context.tr.addressOther,
      Enum$RiderAddressType.$unknown => context.tr.addressOther,
    };
  }
}
