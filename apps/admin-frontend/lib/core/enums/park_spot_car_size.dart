import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkinCarSizeEnumX on Enum$ParkSpotCarSize {
  String text(BuildContext context) {
    switch (this) {
      case Enum$ParkSpotCarSize.LARGE:
        return context.tr.large;
      case Enum$ParkSpotCarSize.MEDIUM:
        return context.tr.medium;
      case Enum$ParkSpotCarSize.SMALL:
        return context.tr.small;
      default:
        return context.tr.unknown;
    }
  }
}

extension ParkSpotCarSizeListX on List<Enum$ParkSpotCarSize> {
  List<FilterItem<Enum$ParkSpotCarSize>> toFilterItems(BuildContext context) =>
      where((carSize) => carSize != Enum$ParkSpotCarSize.$unknown)
          .map(
            (carSize) =>
                FilterItem(value: carSize, label: carSize.text(context)),
          )
          .toList();

  List<AppDropdownItem<Enum$ParkSpotCarSize>> toDropdownItems(
    BuildContext context,
  ) => where((carSize) => carSize != Enum$ParkSpotCarSize.$unknown)
      .map(
        (carSize) =>
            AppDropdownItem(value: carSize, title: carSize.text(context)),
      )
      .toList();
}
