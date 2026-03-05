import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkSpotTypeX on Enum$ParkSpotType {
  IconData get icon => switch (this) {
    Enum$ParkSpotType.PERSONAL => BetterIcons.userFilled,
    Enum$ParkSpotType.PUBLIC => BetterIcons.city02Filled,
    Enum$ParkSpotType.$unknown => BetterIcons.alert02Filled,
  };

  String name(BuildContext context) {
    return switch (this) {
      Enum$ParkSpotType.PERSONAL => context.tr.personal,
      Enum$ParkSpotType.PUBLIC => context.tr.public,
      Enum$ParkSpotType.$unknown => context.tr.unknown,
    };
  }

  String description(BuildContext context) {
    return switch (this) {
      Enum$ParkSpotType.PERSONAL => context.tr.parkSpotPersonalDescription,
      Enum$ParkSpotType.PUBLIC => context.tr.parkSpotPublicDescription,
      Enum$ParkSpotType.$unknown => context.tr.unknown,
    };
  }

  SemanticColor get chipType => switch (this) {
    Enum$ParkSpotType.PERSONAL => SemanticColor.neutral,
    Enum$ParkSpotType.PUBLIC => SemanticColor.neutral,
    Enum$ParkSpotType.$unknown => SemanticColor.warning,
  };

  AppTag toChip(BuildContext context) =>
      AppTag(color: chipType, prefixIcon: icon, text: name(context));
}

extension ParkSpotTypeListX on List<Enum$ParkSpotType> {
  List<FilterItem<Enum$ParkSpotType>> toFilterItems(BuildContext context) =>
      where((type) => type != Enum$ParkSpotType.$unknown)
          .map((type) => FilterItem(value: type, label: type.name(context)))
          .toList();
}
