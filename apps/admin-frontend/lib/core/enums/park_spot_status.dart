import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkSpotStatusX on Enum$ParkSpotStatus {
  SemanticColor get chipType => switch (this) {
    Enum$ParkSpotStatus.Active => SemanticColor.success,
    Enum$ParkSpotStatus.Inactive => SemanticColor.neutral,
    Enum$ParkSpotStatus.Pending => SemanticColor.warning,
    Enum$ParkSpotStatus.Blocked => SemanticColor.error,
    Enum$ParkSpotStatus.$unknown => SemanticColor.warning,
  };

  String title(BuildContext context) => switch (this) {
    Enum$ParkSpotStatus.Active => context.tr.active,
    Enum$ParkSpotStatus.Pending => context.tr.pending,
    Enum$ParkSpotStatus.Blocked => context.tr.blocked,
    Enum$ParkSpotStatus.Inactive => context.tr.inactive,
    Enum$ParkSpotStatus.$unknown => context.tr.unknown,
  };

  AppTag toChip(BuildContext context) =>
      AppTag(text: title(context), color: chipType);
}

extension ParkSpotStatusLisX on List<Enum$ParkSpotStatus> {
  List<FilterItem<Enum$ParkSpotStatus>> toFilterItems(BuildContext context) =>
      where((status) => status != Enum$ParkSpotStatus.$unknown)
          .map(
            (status) => FilterItem(label: status.title(context), value: status),
          )
          .toList();

  List<DropDownStatusItem<Enum$ParkSpotStatus>> toDropdownStatusItems(
    BuildContext context,
  ) => where((status) => status != Enum$ParkSpotStatus.$unknown)
      .map(
        (status) => DropDownStatusItem(
          text: status.title(context),
          value: status,
          chipType: status.chipType,
        ),
      )
      .toList();
}
